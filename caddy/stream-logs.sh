#!/bin/bash
set -e

STREAM_FILE="/root/website/deviceLogs.txt"
message "Streaming logs to '/data/caddy/website/balenaLogs.txt' which is accessible via typing 'IP:PORT/dashboard/balenaLogs.txt' in the browser"
COUNTER=0
curl -X POST -H "Content-Type: application/json" --no-buffer --data '{"follow":true,"all":false,"format":"short"}' "$BALENA_SUPERVISOR_ADDRESS/v2/journal-logs?apikey=$BALENA_SUPERVISOR_API_KEY" \
  | grep -v "avahi-daemon.*|kernel|balenad.*|balena-supervisor.*" \
  | while read -r line ;
    do
      if [ "${COUNTER}" -eq "1000" ]; then
        echo "LOGS STREAMING: flushing logs shown in local dashboard"
        echo "${line}" > "${STREAM_FILE}"
        COUNTER=0
      else
        echo "${line}" >> "${STREAM_FILE}"
        let COUNTER=COUNTER+1
      fi
    done
