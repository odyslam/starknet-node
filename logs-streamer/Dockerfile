FROM alpine:latest
RUN apk add --no-cache curl
COPY ./stream-logs.sh /usr/local/bin/stream-logs.sh
RUN chmod +x /usr/local/bin/stream-logs.sh
ENTRYPOINT ["sh", "/usr/local/bin/stream-logs.sh"]
