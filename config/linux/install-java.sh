#!/usr/bin/env bash

JDK_VERSION=11.0.11.j9-adpt

echo "Configuring Java $JDK_VERSION ..."

# install sdkman!
curl -s "https://get.sdkman.io" | bash
source "$HOME/.sdkman/bin/sdkman-init.sh"

# install jdk
sdk install java $JDK_VERSION

# install maven
sdk install maven
