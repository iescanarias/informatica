#!/usr/bin/env bash

echo "===================================================="
echo "Debian based Linux configuration script v20211117"
echo "Computer Science Department, IES Domingo Pérez Minik"
echo "===================================================="

# check if is running as root
[ $(whoami) != root ] && echo "[ERROR] Please, run as root" && exit 1

IFS=$'\n'	

BASE_URL=https://raw.githubusercontent.com/iesdpm/informatica/master/config/linux
CONFIG_FILE_URL=$BASE_URL/install.conf

# Get config for type (repo | package | deb | installer )
function getConfig() {
	category=$1
	current=""
	for line in $(wget -qO- $CONFIG_FILE_URL | sed -r '/^(\s*|#.*)$/d')
	do
		line=$(echo $line | sed 's/^ *//;s/ *$//')
		case "$line" in
			"[REPO]")
				current="repo"
				;;
			"[PACKAGE]")
				current="package"
				;;
			"[DEB]")
				current="deb"
				;;
			"[INSTALLER]")
				current="installer"
				;;
			*)
				[ "$current" == "$category" ] && echo $line
				;;
		esac
	done
}

# add apt repository
function addRepos() {

	# add keys and repos
	for line in $(getConfig repo)
	do
		name=$(echo $line | cut -d, -f1)
		repo=$(echo $line | cut -d, -f2)
		key=$(echo $line | cut -d, -f3)
		echo "Adding $name repository..."
		[ ! -z "$key" ] && wget -qO- $key | apt-key add -
		apt-add-repository -y $repo && echo "[OK]" || echo "[ERROR]"
	done

	# update database packages list
	echo "Downloading package information from all configured sources ..."
	apt update && echo "[OK]" || echo "[ERROR]"
}

# Install from repos
function installFromRepos() {
	echo "Installing packages from repos..."
	addRepos
	for line in $(getConfig package)
	do
		name=$(echo $line | cut -d, -f1)
		package=$(echo $line | cut -d, -f2)
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
		name=$(echo $line | cut -d, -f1)
		url=$(echo $line | cut -d, -f2)
		installDebFromUrl $name $url
	done
}

# Install software from binary installers
function installFromBinaries() {
	echo "Installing software from binaries/scripts..."
	for line in $(getConfig installer)
	do
		name=$(echo $line | cut -d, -f1)
		user=$(echo $line | cut -d, -f2)
		binary=/tmp/$(echo $line | cut -d, -f3)
		url=$(echo $line | cut -d, -f4)
		echo "Installing $name ..."
		wget -O $binary $url
		chmod +x $binary
		[ "$user" == root ] && $binary || /bin/su -c "$binary" - $user
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
		adduser $username vboxusers
		[ "$admin" = "true" ] && adduser $username sudo
		echo "User $username created!"
	fi
}

# Schedule a task to shutdown computer everyday at 3pm
function scheduleShutdown() {
    echo "Schedule computer shutdown everyday at 3pm..."
	echo "0 15 * * * root /sbin/shutdown -h now" > /etc/cron.d/shutdown
}

# Config AnyDesk only for the current user (alumno)
function configAnyDesk() {
	echo "Configuring AnyDesk for user $1..."
	user=$1

	# Disable AnyDesk service
	systemctl disable anydesk.service

	# Config AnyDesk for alumno
	userHome=$(getent passwd $user | cut -d: -f6)
	autoStart=/home/$userHome/.config/autostart
	mkdir $autoStart
	cp /usr/share/applications/anydesk.desktop $autoStart
	chown -R $user:$user $autoStart

}

# Packages installation
installSoftware

# Create new users
echo "Creating users..."
createUser "alumno" "onmula" true

# Config AnyDesk
configAnyDesk "alumno"

# Schedule a task to shutdown computer everyday at 3pm
scheduleShutdown

# Take out the trash
rm -fr /tmp/*

# Remove duplicated package repositories
SOURCES_PATH=/etc/apt/sources.list.d
rm $SOURCES_PATH/google-chrome.list
rm $SOURCES_PATH/opera-stable.list
rm $SOURCES_PATH/teamviewer.list
rm $SOURCES_PATH/vscode.list

# Upgrade system
apt upgrade -y

# Clean packages cache
apt clean