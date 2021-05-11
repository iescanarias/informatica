#!/usr/bin/env bash

# ======================
# Configure Veyon client
# ======================

# Install Veyon Master tool
apt install -y veyon-service

# Download and install master public key
VEYON_PUBLIC_KEY=/tmp/public_key.pem
wget -O $VEYON_PUBLIC_KEY https://raw.githubusercontent.com/iesdpm/informatica/master/veyon/keys/informatica_public_key.pem

# Import public key
veyon-cli authkeys import informatica/public $VEYON_PUBLIC_KEY

# Set sudo as access group
veyon-cli authkeys setaccessgroup informatica/public sudo

# Set authentication method by key
veyon-cli config set "Authentication/Method" 1

# Enable and restart Veyon service
systemctl enable veyon
systemctl restart veyon
