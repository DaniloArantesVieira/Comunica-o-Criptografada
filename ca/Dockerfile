FROM alpine:3.20

RUN apk add --no-cache openssl bash

WORKDIR /ca

COPY openssl.cnf /ca/openssl.cnf
COPY scripts /ca/scripts

RUN chmod +x /ca/scripts/init_ca.sh /ca/scripts/issue_cert.sh

CMD ["/ca/scripts/init_ca.sh"]
