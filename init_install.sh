#!/bin/bash

# run this script as root (use sudo)
# first argument is name of your user

# check argument and active user
if [[ "$1" == "" ]]; then
	echo "ERROR: specify user name"
	exit 1
fi

if [[ $(whoami) != root ]]; then
	echo "ERROR: run this script as root user (use sudo if necessary)"
	exit 2
fi

# add user and set it up
useradd -m -s /bin/bash "$1"
usermod -aG sudo "$1"
cp ./sudoers /etc/
if [ -e /root/.ssh/authorized_keys ]; then
	cp -r /root/.ssh "/home/$1/"
	chown -R "$1":"$1" "/home/$1/.ssh"
	cp ./sshd_conf /etc/ssh/
fi

# docker
apt remove docker docker-engine docker.io containerd runc \
apt update
apt install -y \
apt-transport-https \
ca-certificates \
curl \
gnupg \
lsb-release
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
apt update
apt install -y docker-ce docker-ce-cli containerd.io

# docker compose
curl -L "https://github.com/docker/compose/releases/download/1.28.6/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# check docker installiation
docker run hello-world

# add user to docker group
usermod -aG docker "$1"
