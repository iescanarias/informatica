#!/bin/bash

echo -e "\nScript de configuración automática de GNU/Linux\nDepartamento de Informática del IES Domingo Pérez Minik\n"

# Load functions from library
library=$(mktemp /tmp/XXXXXXXX.sh)
wget -qO $library https://raw.githubusercontent.com/iesdpm/informatica/master/config/linux/functions.sh
source $library

# Check if is running as administrator
if isRunningAsRoot
then

    # Packages installation
    installPackages

    # Create new users
    echo "Creating users..."
    createUser "profesor" "roseforp" true
    createUser "alumno" "onmula" false

    # Schedule a task to shutdown computer everyday at 3pm
    scheduleShutdown

else

    echo "Must be run as root"

fi
