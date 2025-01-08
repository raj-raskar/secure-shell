#!/bin/bash

#Setup sshd
apt-get install -qq -o=Dpkg::Use-Pty=0 openssh-server pwgen > /dev/null
echo "Secure Shell Installed."

#Set root password
echo root:toor | chpasswd
echo "root Password changed."
mkdir -p /var/run/sshd
echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config
echo "Modified Secure Shell."

#Run sshd
/usr/sbin/sshd -D &
echo "Started Secure Shell."

#Download wstunnel
wget -O wstunnel https://github.com/raj-raskar/secure-shell/raw/refs/heads/main/wstunnel
chmod +x wstunnel
echo "Downloaded wstunnel."

#Create tunnel
echo "Starting Tunnel."
./wstunnel client -R "tcp://2222:localhost:22" --http-headers "nrok-skip-browser-warning: true" $1
