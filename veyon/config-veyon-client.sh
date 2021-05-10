#!/usr/bin/env bash

# ==============================
# Configure Veyon client service
# ==============================

# Download and install master public key
VEYON_PUBLIC_KEY=/tmp/public_key.pem
wget -qO $VEYON_PUBLIC_KEY https://raw.githubusercontent.com/iesdpm/informatica/master/veyon/keys/informatica_public_key.pem
veyon-cli authkeys import informatica/public $VEYON_PUBLIC_KEY

# Enable and start Veyon service
systemctl enable veyon
systemctl restart veyon
