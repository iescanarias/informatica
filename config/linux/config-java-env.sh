#!/bin/bash

echo "Configuring Java development environment ..."

JDK_VERSION=16.0.0.j9-adpt
ECLIPSE_VERSION=2021-03

# install sdkman!
curl -s "https://get.sdkman.io" | bash
source "$HOME/.sdkman/bin/sdkman-init.sh"

# install jdk
sdk install java $JDK_VERSION

# install maven
sdk install maven

# install eclipse ide for java developers

ECLIPSE_DOWNLOAD_URL=https://mirrors.dotsrc.org/eclipse/technology/epp/downloads/release/$ECLIPSE_VERSION/R/eclipse-java-$ECLIPSE_VERSION-R-linux-gtk-x86_64.tar.gz
ECLIPSE_FILE=~/.sdkman/archives/eclipse.tgz
ECLIPSE_INSTALL_DIR=~/.sdkman/candidates/eclipse/$ECLIPSE_VERSION

wget -qO $ECLIPSE_FILE $ECLIPSE_DOWNLOAD_URL
tar xvfz $ECLIPSE_FILE
mkdir -p ~/.sdkman/candidates/eclipse
mv ~/.sdkman/archives/eclipse $ECLIPSE_INSTALL_DIR
ln -s $ECLIPSE_INSTALL_DIR ~/.sdkman/candidates/eclipse/current

cat > ~/.local/share/applications/eclipse.desktop <<EOL
[Desktop Entry]
Name=Eclipse
Type=Application
Exec=~/.sdkman/candidates/eclipse/current/eclipse
Terminal=false
Icon=~/.sdkman/candidates/eclipse/current/icon.xpm
Comment=Eclipse for Java Developers
NoDisplay=false
Categories=Development;IDE;
EOL

ln -s ~/.sdkman/candidates/java/current ~/.sdkman/candidates/eclipse/current/jre