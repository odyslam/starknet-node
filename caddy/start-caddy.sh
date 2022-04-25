#!/bin/bash
set -e
message() {
    echo
    echo -----------------------------------------------------------------------------
    echo -e "$@"
    echo -----------------------------------------------------------------------------
    echo
}

message "Starting Caddy with the following credentials:"
echo "USERNAME: ${CADDY_USERNAME}"
echo "PASSWORD: ${CADDY_PASSWORD}"
echo
export CADDY_PASSWORD_HASH=$(caddy hash-password --plaintext ${CADDY_PASSWORD})
# Add credentials to dashboard, required to load the deviceLogs.txt file
# Since the website is only loaded if basic AUTH is succesful, the plaintext credentials pose no additional security threat
sed -i "s/CADDY_PASSWORD/${CADDY_PASSWORD}/g" /root/website/index.js && sed -i "s/CADDY_USERNAME/${CADDY_USERNAME}/g" /root/website/index.js
caddy run --config /etc/caddy/Caddyfile
# Used for debugging
# tail -f /dev/null
