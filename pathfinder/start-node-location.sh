#!/bin/bash
set -e
message() {

    echo
    echo -----------------------------------------------------------------------------
    echo "$@"
    echo -----------------------------------------------------------------------------
    echo
}

if [[ "$LOCATION" = "OFF" || "$LOCATION" = "off" ]]; then
  message "Detected LOCATION=OFF. The Node will not report it's location to Starkware"
else
  message "Detected LOCATION=ON. The Node will report it's location to Starkware and appear on the global map of Starkware Nodes"
  echo "Location API endpoint: ${LOCATION_API}"
  echo "Device UUID: $(cat /var/location_uuid)"
  sh /usr/local/bin/ping.sh &

fi
sh /usr/local/bin/start-node.sh
