#!/bin/bash

echo "===================================================="
echo "Debian based Linux configuration script"
echo "Computer Science Department, IES Domingo Pérez Minik"
echo "===================================================="

# check if is running as root
[ $(whoami) != root ] && echo "[ERROR] Please, run as root" && exit 1

IFS=$'\n'	

BASE_URL=https://raw.githubusercontent.com/iesdpm/informatica/master/config/linux
CONFIG_FILE_URL=$BASE_URL/install.conf

# Get config for type
function getConfig() {
	type=$1
	wget -qO- $CONFIG_FILE_URL | sed -r '/^(\s*|#.*)$/d' | grep "^$type,"
}

# add apt repository
function addRepos() {

	# add keys and repos
	for line in $(getConfig repo)
	do
		name=$(echo $line | cut -d, -f2)
		repo=$(echo $line | cut -d, -f3)
		key=$(echo $line | cut -d, -f4)
		echo "Adding $name repository..."
		[ ! -z "$key" ] && wget -qO- $key | apt-key add -
		apt-add-repository -y $repo && echo "[OK"] || echo "[ERROR]"
	done

	# update database packages list
	echo "Downloading package information from all configured sources ..."
	apt update && echo "[OK"] || echo "[ERROR]"
}

# Install from repos
function installFromRepos() {
	echo "Installing packages from repos..."
	addRepos
	for line in $(getConfig package)
	do
		name=$(echo $line | cut -d, -f2)
		package=$(echo $line | cut -d, -f3)
		echo "Installing $name package from repo..."
		apt install -y $package && echo "[OK]" || echo "[ERROR]"
	done
}

# Installs DEB package from URL
function installDebFromUrl() {
	name=$1
	url=$2
	deb=/tmp/$(basename $url)
	echo "Installing $name package from DEB file..."
	wget -O $deb $url
	dpkg -i $deb && echo "[OK]" || echo "[ERROR]"
}

# Install DEB packages from URLs in config file
function installDebsFromUrls() {
	echo "Installing DEB files from urls..."
	for line in $(getConfig deb)
	do
		name=$(echo $line | cut -d, -f2)
		url=$(echo $line | cut -d, -f3)
		installDebFromUrl $name $url
	done
}

# Install software from binary installers
function installFromBinaries() {
	echo "Installing software from binaries/scripts..."
	for line in $(getConfig installer)
	do
		name=$(echo $line | cut -d, -f2)
		user=$(echo $line | cut -d, -f3)
		binary=/tmp/$(echo $line | cut -d, -f4)
		url=$(echo $line | cut -d, -f5)
		echo "Installing $name ..."
		wget -O $binary $url
		chmod +x $binary
		[ "$username" == root ] && $binary || /bin/su -c "$binary" - $username
	done
}

# Install software
function installSoftware() {
	echo "Installing packages..."
	installFromRepos
	installDebsFromUrls
	installFromBinaries
}

# Create new user
function createUser() {
    echo "Creating user $1..."
	username=$1
	password=$2
	admin=$3
	if cat /etc/passwd | grep $username; then
		echo "User $username already exists"
	else
		useradd -m -s /bin/bash $username
		echo $username:$password | chpasswd
		[ "$admin" = "true" ] && adduser $username sudo
		echo "User $username created!"
	fi
}

# Schedule a task to shutdown computer everyday at 3pm
function scheduleShutdown() {
    echo "Schedule computer shutdown everyday at 3pm..."
	echo "0 15 * * * root /sbin/shutdown -h now" > /etc/cron.d/shutdown
}

# Create new users
echo "Creating users..."
createUser "alumno" "onmula" true

# Packages installation
installSoftware

# Upgrade system
apt upgrade

# Schedule a task to shutdown computer everyday at 3pm
scheduleShutdown

# Take out the trash
rm -fr /tmp/*
