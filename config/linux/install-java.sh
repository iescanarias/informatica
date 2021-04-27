#!/bin/bash

JDK_VERSION=11.0.11.j9-adpt
ECLIPSE_VERSION=2021-03

echo "Configuring Java $JDK_VERSION ..."

# install sdkman!
curl -s "https://get.sdkman.io" | bash
source "$HOME/.sdkman/bin/sdkman-init.sh"

# install jdk
sdk install java $JDK_VERSION

# install maven
sdk install maven

# install eclipse ide for java developers

echo "Installing Eclipse $ECLIPSE_VERSION ..."

ECLIPSE_DOWNLOAD_URL=https://mirrors.dotsrc.org/eclipse/technology/epp/downloads/release/$ECLIPSE_VERSION/R/eclipse-java-$ECLIPSE_VERSION-R-linux-gtk-x86_64.tar.gz
ECLIPSE_FILE=~/.sdkman/archives/eclipse.tgz
ECLIPSE_INSTALL_DIR=~/.sdkman/candidates/eclipse/$ECLIPSE_VERSION

wget -qO $ECLIPSE_FILE $ECLIPSE_DOWNLOAD_URL
tar xfz $ECLIPSE_FILE
mkdir -p ~/.sdkman/candidates/eclipse
mv ~/.sdkman/archives/eclipse $ECLIPSE_INSTALL_DIR
ln -s $ECLIPSE_INSTALL_DIR ~/.sdkman/candidates/eclipse/current
ln -s ~/.sdkman/candidates/java/current ~/.sdkman/candidates/eclipse/current/jre

mkdir -p ~/.local/share/applications
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
