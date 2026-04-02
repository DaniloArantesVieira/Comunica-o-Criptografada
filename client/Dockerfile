FROM alpine:3.20

RUN apk add --no-cache openvpn bash iproute2

WORKDIR /client

COPY client.conf /client/client.conf
COPY scripts /client/scripts

RUN chmod +x /client/scripts/entrypoint.sh

CMD ["/client/scripts/entrypoint.sh"]
