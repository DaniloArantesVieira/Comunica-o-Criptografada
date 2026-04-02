#!/bin/bash
set -e

echo "[SERVER] Iniciando OpenVPN Server..."
ls -R /certs || true

openvpn --config /server/server.conf
