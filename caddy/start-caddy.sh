#!/bin/bash
set -e
# Set the hostname of the device using the balena supervisor API
curl -f -s -X PATCH --header "Content-Type:application/json" \
    --data '{"network": {"hostname": "starknet"}}' \
    "$BALENA_SUPERVISOR_ADDRESS/v1/device/host-config?apikey=$BALENA_SUPERVISOR_API_KEY" \
    && echo && echo "Starknet Node set hostname to 'starknet'. You can access the device by typing starknet.local on your browser" \
    || echo "Starknet Node failed to set the hostname of the device. If you are not using balena but regular Docker, this is normal."
# Save the credentials of the device and the API token in a file. This is used by the dashboard to leverage the balena SDK and stream logs directly,
# without the user needing to visit balena-cloud.
# If the project runs on regular Docker, then the credentials will be empty and won't be used.
echo "{\"balenaToken\": \"${BALENA_API_KEY}\", \"balenaDeviceUUID\":\"${BALENA_DEVICE_UUID}\"}" > /root/website/balena.json
if [[ -z ${CADDY_PASSWORD} ]]; then
  CADDY_PASSWORD=${BALENA_DEVICE_UUID}
fi
export CADDY_PASSWORD_HASH=$(caddy hash-password ${CADDY_PASSWORD})
caddy run --config /etc/caddy/Caddyfile
