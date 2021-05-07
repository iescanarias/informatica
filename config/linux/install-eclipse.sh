#!/usr/bin/env bash
# install eclipse ide for java developers

ECLIPSE_VERSION=2021-03
ECLIPSE_DOWNLOAD_URL=https://mirrors.dotsrc.org/eclipse/technology/epp/downloads/release/$ECLIPSE_VERSION/R/eclipse-java-$ECLIPSE_VERSION-R-linux-gtk-x86_64.tar.gz
ECLIPSE_TGZ=/tmp/eclipse.tgz
ECLIPSE_INSTALL_DIR=$HOME/eclipse/$ECLIPSE_VERSION
[ -z "$JAVA_HOME" ] && JAVA_HOME=$(basename $(basename $(which java)))

echo "Installing Eclipse $ECLIPSE_VERSION for Java Developers ..."

wget -O $ECLIPSE_TGZ $ECLIPSE_DOWNLOAD_URL
cd /tmp && tar xfz $ECLIPSE_TGZ
mkdir -p $HOME/eclipse
mv /tmp/eclipse $ECLIPSE_INSTALL_DIR
ln -s $JAVA_HOME $ECLIPSE_INSTALL_DIR/jre

mkdir -p $HOME/.local/share/applications
cat > $HOME/.local/share/applications/eclipse.desktop <<EOL
[Desktop Entry]
Version=2021-03
Name=Eclipse IDE
Type=Application
Exec=$ECLIPSE_INSTALL_DIR/eclipse %U
Terminal=false
Icon=$ECLIPSE_INSTALL_DIR/icon.xpm
Comment=Eclipse for Java Developers
NoDisplay=false
Categories=Development;IDE;
EOL

# install object-aid uml explorer plugin
$ECLIPSE_INSTALL_DIR/eclipse \
    -nosplash \
    -application org.eclipse.equinox.p2.director \
    -repository http://www.objectaid.com/update/current \
    -repository http://download.eclipse.org/releases/$ECLIPSE_VERSION \
    -destination $ECLIPSE_INSTALL_DIR \
    -installIU org.apache.batik.feature.group \
    -installIU com.objectaid.uml.cls.feature.group
