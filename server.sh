#!/bin/bash

#Setup sshd
apt-get install -qq -o=Dpkg::Use-Pty=0 openssh-server pwgen > /dev/null 2>&1 &
echo "Installed."

#Set root password
echo root:toor | chpasswd > /dev/null 2>&1 &
echo "Chpasswd."
mkdir -p /var/run/sshd
echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config
echo "Modified."

#Run sshd
/usr/sbin/sshd -D > /dev/null 2>&1 &
echo "Started."

#Download wstunnel
wget -O wstunnel https://github.com/raj-raskar/secure-shell/raw/refs/heads/main/wstunnel > /dev/null 2>&1 &
chmod +x wstunnel
echo "Downloaded."

#Create tunnel
echo "Drilled."
./wstunnel client -R "tcp://2222:localhost:22" --http-headers "nrok-skip-browser-warning: true" $1 > /dev/null 2>&1
