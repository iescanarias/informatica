#!/bin/bash

echo -e "\nScript de configuración automática de GNU/Linux\nDepartamento de Informática del IES Domingo Pérez Minik\n"

# check if is running as root
[ $(whoami) != root ] && echo "[ERROR] Please, run as root" && exit 1

packagesFileUrl=https://raw.githubusercontent.com/iesdpm/informatica/master/config/linux/packages.txt
urlsFileUrl=https://raw.githubusercontent.com/iesdpm/informatica/master/config/linux/urls.txt

# add apt key
function addAptKey() {
	echo "Add $1 APT key"
	url=$1
	wget -qO- $url | sudo apt-key add -
}

function addAptRepo() {
	echo "Add $1 repo to APT sources"
	repo=/etc/apt/sources.list.d/$1.list
	line=$2
	if [ ! -f $repo ]; then
		echo $line > $repo
	else
		echo "Repo $repo already exists"
	fi
}

# Installs DEB package from URL
function installFromUrl() {
	url=$1
	deb=/tmp/$(basename $url)
	wget -qO $deb $url
	dpkg -i $deb
}

# Install from repos
function installFromRepos() {
	echo "Installing packages from repos..."
	for package in $(wget -qO- $packagesFileUrl)
	do
		if [ ! -z "$package" ]
		then
			echo "Installing $package package..."
			apt install -y $package
		fi
	done
}

# Install from URLs
function installFromUrls() {
        echo "Installing packages from urls..."
        for url in $(wget -qO- $urlsFileUrl)
        do
                if [ ! -z "$url" ]
                then
                        "Installing $url package..."
			installFromUrl $url
                fi
        done
}


# add apt repository
function addRepos() {

	echo "Adding new APT repositories..."

	# add keys
	addAptKey "https://dl.google.com/linux/linux_signing_key.pub"

	# add repos
	addAptRepo "google-chrome" "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" 

	# update database packages list
	apt update

}

# packages installation
function installPackages() {
	echo "Installing packages..."
	addRepos
	installFromRepos
	installFromUrls
}

# create new user
function createUser() {
        echo "Creating user $1..."
	username=$1
	pasword=$2
	admin=$3
	if cat /etc/passwd | grep $username; then
		echo "User $username already exists"
	else
		useradd -m -s /bin/bash $username
		echo $username:$password | chpasswd
		if [ "$admin" = "true" ]; then
			adduser $username sudo
		fi
		echo "User $username created"
	fi
}

# schedule a task to shutdown computer everyday at 3pm
function scheduleShutdown() {
        echo "Schedule computer shutdown everyday at 3pm..."
	echo "0 15 * * * root /sbin/shutdown -h now" > /etc/cron.d/shutdown
}

# Packages installation
installPackages

# Create new users
echo "Creating users..."
createUser "profesor" "roseforp" true
createUser "alumno" "onmula" false

# Schedule a task to shutdown computer everyday at 3pm
scheduleShutdown

# Empty temporary directory
rm -fr /tmp/*
