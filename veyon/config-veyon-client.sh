#!/usr/bin/env bash

# ==============================
# Configure Veyon client service
# ==============================

# Download and install master public key
VEYON_KEYS_DIR=/etc/veyon/keys/public/informatica
mkdir -p $VEYON_KEYS_DIR
wget -qO $VEYON_KEYS_DIR/key https://raw.githubusercontent.com/iesdpm/informatica/master/veyon/keys/informatica_public_key.pem

# Enable and start Veyon client service
systemctl enable veyon
systemctl start veyon
