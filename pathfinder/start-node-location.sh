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
  echo "The device pings on regular intervals a website owned and operated by Starkware"
  echo "This is done so that the approximate location of the Node may be infered from the HTTP request"
  echo "Starkware uses this information to create a map of Starknet Nodes, emphasizing the importance of being able to run a node without the need of powerful hardware"
  echo "It's an effort to show that Starknet is decentralized in a very important way, being able to be verified by thousand of small devices from various parts of the world"
  echo "Starkware is not sharing this information with no 3rd party and the actual HTTP request does not transmit any information about the device"
  echo "The inference of the location of the device is solely based on the IP that the HTTP request originates"
  message "Location API endpoint: ${LOCATION_API}"
  message "Device UUID: $(cat /var/location_uuid)"
  sh /usr/local/bin/ping.sh &

fi
sh /usr/local/bin/start-node.sh
