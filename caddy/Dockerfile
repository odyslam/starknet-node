FROM caddy:2.4.5-builder AS builder
RUN xcaddy build
FROM caddy:2.4.5-alpine
RUN apk update && apk --no-cache add curl vim
COPY --from=builder /usr/bin/caddy /usr/bin/caddy
COPY ./Caddyfile /etc/caddy/Caddyfile
COPY ./start-caddy.sh /usr/local/bin/start-caddy.sh
COPY ./website /root/website
RUN chmod +x /usr/local/bin/start-caddy.sh
ENTRYPOINT ["sh", "/usr/local/bin/start-caddy.sh"]
