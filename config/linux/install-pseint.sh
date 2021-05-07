#!/usr/bin/env bash

echo "Installing PSeInt ..."

APP_NAME=pseint
DOWNLOAD_URL=http://prdownloads.sourceforge.net/pseint/pseint-l64-20210408.tgz?download
FILE=/tmp/$APP_NAME.tgz
INSTALL_DIR=/opt

wget -O $FILE $DOWNLOAD_URL
cd /tmp && tar xfz $FILE
mv /tmp/$APP_NAME $INSTALL_DIR

cat > /usr/share/applications/$APP_NAME.desktop <<EOL
[Desktop Entry]
Version=20210408
Name=PSeInt
Comment=Herramienta para asistir a un estudiante en sus primeros pasos en programación
Type=Application
Exec=$INSTALL_DIR/$APP_NAME/pesint %U
Icon=$INSTALL_DIR/$APP_NAME/imgs/logo.png
Terminal=false
NoDisplay=false
Categories=Development;IDE;
EOL
