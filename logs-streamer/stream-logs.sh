#!/bin/bash
set -e
message() {
    echo
    echo -----------------------------------------------------------------------------
    echo -e "$@"
    echo -----------------------------------------------------------------------------
}

# Set the hostname of the device using the balena supervisor API
curl -f -s -X PATCH --header "Content-Type:application/json" \
    --data '{"network": {"hostname": "starknet"}}' \
    "$BALENA_SUPERVISOR_ADDRESS/v1/device/host-config?apikey=$BALENA_SUPERVISOR_API_KEY" \
    && echo && echo "Starknet Node set hostname to 'starknet'. You can access the device by typing starknet.local on your browser" \
    || echo "Starknet Node failed to set the hostname of the device. If you are not using balena but regular Docker, this is normal."

STREAM_PATH="/data/caddy/device"
STREAM_FILE="${STREAM_PATH}/logs.txt"
mkdir -p ${STREAM_PATH} && touch ${STREAM_FILE}

COUNTER=0
GREP_FILTER="avahi-daemon.*|kernel.*|balenad.*|balena-supervisor.*"
message "Streaming logs to ${STREAM_FILE} which is accessible via typing 'IP:PORT/device/logs.txt' in the browser"
message "Streaming logs to ${STREAM_FILE} with filter: ${GREP_FILTER}"
curl -X POST -H "Content-Type: application/json" --no-buffer --data '{"follow":true,"all":false,"format":"short"}' "$BALENA_SUPERVISOR_ADDRESS/v2/journal-logs?apikey=$BALENA_SUPERVISOR_API_KEY" \
  | grep -v "${GREP_FILTER}" \
  > "${STREAM_FILE}"
