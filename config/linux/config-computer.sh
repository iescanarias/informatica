#!/bin/bash

echo -e "\nScript de configuración automática de GNU/Linux\nDepartamento de Informática del IES Domingo Pérez Minik\n"

# Load functions from library
wget -q0- https://raw.githubusercontent.com/iesdpm/informatica/master/scripts/linux/functions.sh | .

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
