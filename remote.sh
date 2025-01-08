#!/bin/bash

#Setup sshd
apt-get install -qq -o=Dpkg::Use-Pty=0 openssh-server pwgen > /dev/null

#Set root password
echo root: | chpasswd
mkdir -p /var/run/sshd
echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config

#Run sshd
/usr/sbin/sshd -D &

#Download wstunnel
wget -O wstunnel https://github.com/raj-raskar/secure-shell/raw/refs/heads/main/wstunnel
chmod +x wstunnel

#Create tunnel
./wstunnel client -R "tcp://2222:localhost:22" --http-headers "nrok-skip-browser-warning: true" $1
