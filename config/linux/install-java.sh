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
ECLIPSE_FILE=/tmp/eclipse.tgz
ECLIPSE_INSTALL_DIR=$HOME/.sdkman/candidates/eclipse/$ECLIPSE_VERSION
ECLIPSE_LINK=$HOME/.sdkman/candidates/eclipse/current

wget -qO $ECLIPSE_FILE $ECLIPSE_DOWNLOAD_URL
cd /tmp && tar xfz $ECLIPSE_FILE
mkdir -p $HOME/.sdkman/candidates/eclipse
mv /tmp/eclipse $ECLIPSE_INSTALL_DIR
ln -s $ECLIPSE_INSTALL_DIR $ECLIPSE_LINK
ln -s $HOME/.sdkman/candidates/java/current $ECLIPSE_LINK/jre

mkdir -p $HOME/.local/share/applications
cat > $HOME/.local/share/applications/eclipse.desktop <<EOL
[Desktop Entry]
Name=Eclipse
Type=Application
Exec=$ECLIPSE_LINK/eclipse
Terminal=false
Icon=$ECLIPSE_LINK/icon.xpm
Comment=Eclipse for Java Developers
NoDisplay=false
Categories=Development;IDE;
EOL

# install object-aid uml explorer plugin
$ECLIPSE_LINK/eclipse \
    -nosplash \
    -application org.eclipse.equinox.p2.director \
    -repository http://www.objectaid.com/update/current \
    -destination $ECLIPSE_LINK \
    -installIU org.apache.batik.feature.group \
    -installIU com.objectaid.uml.cls.feature.group \
    -installIU com.objectaid.uml.addon.feature.group \
    -installIU com.objectaid.uml.seq.feature.group