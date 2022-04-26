FROM eqlabs/pathfinder:latest

USER root

RUN apk add --no-cache util-linux curl

COPY start-node-location.sh /usr/local/bin/start-node-location.sh
COPY ping.sh /usr/local/bin/ping.sh

RUN chmod +x /usr/local/bin/ping.sh && \
      chmod 755 /usr/local/bin/ping.sh && \
      chmod +x /usr/local/bin/start-node-location.sh && \
      chmod 755 /usr/local/bin/start-node-location.sh

RUN addgroup -g 1000 pathfinder && adduser -u 1000 -G pathfinder -H -D pathfinder

RUN  uuidgen >> /var/location_uuid && chmod 755 /var/location_uuid

USER pathfinder

WORKDIR /usr/share/pathfinder/data

ENTRYPOINT ["sh", "/usr/local/bin/start-node-location.sh"]
