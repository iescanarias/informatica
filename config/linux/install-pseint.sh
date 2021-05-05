#!/bin/bash

echo "Installing PSeInt ..."

APP_NAME=pseint
DOWNLOAD_URL=http://prdownloads.sourceforge.net/pseint/pseint-l64-20210408.tgz?download
FILE=/tmp/$APP_NAME.tgz
INSTALL_DIR=/opt

wget -O $FILE $DOWNLOAD_URL
tar xfz $FILE
mv $APP_NAME $INSTALL_DIR

cat > /usr/share/applications/$APP_NAME.desktop <<EOL
[Desktop Entry]
Name=PSeInt
Type=Application
Exec=$INSTALL_DIR/$APP_NAME/bin/wxPSeInt
Terminal=false
Icon=$INSTALL_DIR/$APP_NAME/imgs/logo.png
Comment=PSeInt
NoDisplay=false
Categories=Development;IDE;
EOL
