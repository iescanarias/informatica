#!/usr/bin/env bash

echo "Installing PSeInt ..."

APP_NAME=pseint
DOWNLOAD_URL=http://prdownloads.sourceforge.net/pseint/pseint-l64-20210427.tgz?download
FILE=/tmp/$APP_NAME.tgz
INSTALL_DIR=/opt

wget -O $FILE $DOWNLOAD_URL
cd /tmp && tar xfz $FILE
mv /tmp/$APP_NAME $INSTALL_DIR

cat > /usr/share/applications/$APP_NAME.desktop <<EOL
[Desktop Entry]
Encoding=UTF-8
Name=PSeInt
Comment=Tool to learn programming
Type=Application
Exec=$INSTALL_DIR/$APP_NAME/wxPSeInt
Icon=$INSTALL_DIR/$APP_NAME/imgs/logo.png
Terminal=false
Categories=Development;
EOL
