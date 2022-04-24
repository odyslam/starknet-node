#!/bin/bash
set -e
message() {
    echo
    echo -----------------------------------------------------------------------------
    echo -e "$@"
    echo -----------------------------------------------------------------------------
    echo
}
# Set the hostname of the device using the balena supervisor API
curl -f -s -X PATCH --header "Content-Type:application/json" \
    --data '{"network": {"hostname": "starknet"}}' \
    "$BALENA_SUPERVISOR_ADDRESS/v1/device/host-config?apikey=$BALENA_SUPERVISOR_API_KEY" \
    && echo && echo "Starknet Node set hostname to 'starknet'. You can access the device by typing starknet.local on your browser" \
    || echo "Starknet Node failed to set the hostname of the device. If you are not using balena but regular Docker, this is normal."

# Start streaming logs to a file that is later loaded via the dashboard
sh /usr/local/bin/stream-logs.sh &

message "Starting Caddy with the following credentials:"
echo "USERNAME: ${CADDY_USERNAME}"
echo "PASSWORD: ${CADDY_PASSWORD}"
echo
export CADDY_PASSWORD_HASH=$(caddy hash-password --plaintext ${CADDY_PASSWORD})
# Add credentials to dashboard, required to load the deviceLogs.txt file
# Since the website is only loaded if basic AUTH is succesful, the plaintext credentials pose no additional security threat
sed -i "s/CADDY_PASSWORD/${CADDY_PASSWORD}/g" /root/website/index.js && sed -i "s/CADDY_USERNAME/${CADDY_USERNAME}/g" /root/website/index.js
caddy run --config /etc/caddy/Caddyfile
