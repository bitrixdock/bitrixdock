#!/bin/bash

CERT_KEY="/etc/nginx/certs/bitrix.local-key.pem"
CERT_FILE="/etc/nginx/certs/bitrix.local-cert.pem"

if [ ! -f "$CERT_KEY" ] || [ ! -f "$CERT_FILE" ]; then
    mkcert -install
    mkcert -key-file "$CERT_KEY" -cert-file "$CERT_FILE" bitrix.loc
fi
