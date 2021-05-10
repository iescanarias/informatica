#!/usr/bin/env bash

# ======================
# Configure Veyon master
# ======================

# Install Veyon Master tool
apt install -y veyon-master

# Download and install master private key
VEYON_PRIVATE_KEY=/tmp/private_key.pem
wget -O $VEYON_PRIVATE_KEY https://raw.githubusercontent.com/iesdpm/informatica/master/veyon/keys/informatica_private_key.pem
veyon-cli authkeys import informatica/private $VEYON_PRIVATE_KEY
veyon-cli authkeys setaccessgroup informatica/private sudo
veyon-cli config set "Authentication/Method" 1

# Enable and start Veyon service
systemctl enable veyon
systemctl restart veyon