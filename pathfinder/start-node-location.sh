#!/bin/bash
set -e
message() {

    echo
    echo -----------------------------------------------------------------------------
    echo "$@"
    echo -----------------------------------------------------------------------------
    echo
}

if [[ "$NODE_LOCATION" = "OFF" || "$NODE_LOCATION" = "off" ]]; then
  message "Detected LOCATION=OFF. The Node will not report it's location to Starkware"
else
  message "Detected LOCATION=ON. The Node will report it's location to Starkware and appear on the global map of Starkware Nodes"
  echo "The device pings a StarkWare website at regular intervals, so that the approximate Node location may be inferred from the HTTP request"
  echo "StarkWare uses this information to create a map of StarkNet Nodes"
  echo "StarkWare will not share this information with any 3rd party, and the actual HTTP request does not transmit any information about the device"
  echo "The location of the device is based solely based on the IP that the HTTP request originates from"
  message "Location API endpoint: ${NODE_LOCATION_API}"
  message "Device UUID: $(cat /var/location_uuid)"
  sh /usr/local/bin/ping.sh &
fi

if [ "$NODE_IDLE" == "1" ]; then
    echo "Detected \$IDLE=1 env variable"
    echo "Starknet Pathfinder will now idle"
    echo "To restart normally, remove the env variable and the container will restart"
    tail -f /dev/null
fi
tini -s -- /usr/local/bin/pathfinder
