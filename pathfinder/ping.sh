#!/bin/bash

set -e
while true
do
    curl -sS "$LOCATION_API?nodeId=$(cat /var/location_uuid)" > /dev/null
    # Sleep for one day
    sleep 86400
done
