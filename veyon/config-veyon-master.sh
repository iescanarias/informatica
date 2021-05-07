#!/usr/bin/env bash

# ======================
# Configure Veyon master
# ======================

apt install -y veyon-master

# Download and install master private key
VEYON_KEYS_DIR=/etc/veyon/keys/private/informatica
mkdir -p $VEYON_KEYS_DIR
wget -qO $VEYON_KEYS_DIR/key https://raw.githubusercontent.com/iesdpm/informatica/master/keys/veyon/informatica_private_key.pem

# Enable and start Veyon client service
systemctl enable veyon
systemctl restart veyon
