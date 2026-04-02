#!/bin/bash
set -e

echo "[CA] Inicializando estrutura da CA..."

mkdir -p /certs/ca/certs
mkdir -p /certs/ca/crl
mkdir -p /certs/ca/newcerts
mkdir -p /certs/ca/private
touch /certs/ca/index.txt
echo 1000 > /certs/ca/serial

mkdir -p /certs/server
mkdir -p /certs/cliente_norte
mkdir -p /certs/cliente_sul

if [ ! -f /certs/ca/private/ca.key.pem ]; then
  echo "[CA] Gerando chave privada ECC P-256 da CA..."
  openssl ecparam -name prime256v1 -genkey -noout -out /certs/ca/private/ca.key.pem
fi

if [ ! -f /certs/ca/certs/ca.cert.pem ]; then
  echo "[CA] Gerando certificado raiz autoassinado..."
  openssl req -x509 -new -nodes \
    -key /certs/ca/private/ca.key.pem \
    -sha256 -days 3650 \
    -config /ca/openssl.cnf \
    -out /certs/ca/certs/ca.cert.pem
fi

echo "[CA] Emitindo certificados dos nós..."
/ca/scripts/issue_cert.sh server server_cert
/ca/scripts/issue_cert.sh cliente_norte client_cert
/ca/scripts/issue_cert.sh cliente_sul client_cert

echo "[CA] Artefatos gerados com sucesso."
echo "[CA] Finalizado."
