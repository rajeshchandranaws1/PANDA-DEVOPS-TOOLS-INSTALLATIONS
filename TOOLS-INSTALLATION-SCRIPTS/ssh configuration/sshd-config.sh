#!/bin/bash

read -p "Enter the Username Name  : " uname

if [ $(grep -c "$uname ALL=(ALL) NOPASSWD: ALL" /etc/sudoers)  -eq 0 ]; then
echo "$uname ALL=(ALL) NOPASSWD: ALL" | sudo EDITOR='tee -a' visudo;
fi;

sed -i 's/#PermitRootLogin[[:space:]]yes/PermitRootLogin yes/' /etc/ssh/sshd_config
sed -i 's/#PasswordAuthentication[[:space:]]yes/PasswordAuthentication yes/' /etc/ssh/sshd_config
sed -i 's/PasswordAuthentication[[:space:]]no/#PasswordAuthentication no/' /etc/ssh/sshd_config
sed -i 's/##PasswordAuthentication[[:space:]]no/#PasswordAuthentication no/' /etc/ssh/sshd_config

/usr/bin/systemctl restart sshd.service
