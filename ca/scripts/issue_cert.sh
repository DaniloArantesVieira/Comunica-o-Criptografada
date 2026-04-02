#!/bin/bash
set -e

NODE_NAME="$1"
EXT_SECTION="$2"

if [ -z "$NODE_NAME" ] || [ -z "$EXT_SECTION" ]; then
  echo "Uso: issue_cert.sh <node_name> <server_cert|client_cert>"
  exit 1
fi

NODE_DIR="/certs/${NODE_NAME}"
CA_KEY="/certs/ca/private/ca.key.pem"
CA_CERT="/certs/ca/certs/ca.cert.pem"

mkdir -p "${NODE_DIR}"

echo "[CA] Gerando chave ECC para ${NODE_NAME}..."
openssl ecparam -name prime256v1 -genkey -noout -out "${NODE_DIR}/${NODE_NAME}.key.pem"

echo "[CA] Gerando CSR para ${NODE_NAME}..."
openssl req -new \
  -key "${NODE_DIR}/${NODE_NAME}.key.pem" \
  -subj "/CN=${NODE_NAME}" \
  -out "${NODE_DIR}/${NODE_NAME}.csr.pem"

echo "[CA] Assinando certificado de ${NODE_NAME}..."
openssl x509 -req \
  -in "${NODE_DIR}/${NODE_NAME}.csr.pem" \
  -CA "${CA_CERT}" \
  -CAkey "${CA_KEY}" \
  -CAcreateserial \
  -out "${NODE_DIR}/${NODE_NAME}.cert.pem" \
  -days 825 \
  -sha256 \
  -extfile /ca/openssl.cnf \
  -extensions "${EXT_SECTION}"

cp "${CA_CERT}" "${NODE_DIR}/ca.cert.pem"

echo "[CA] Certificado emitido para ${NODE_NAME}."
