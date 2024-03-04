#!/bin/bash

read -p "Enter the Username Name  : " uname

adduser $uname
passwd $uname

if [ $(grep -c "$uname ALL=(ALL) NOPASSWD: ALL" /etc/sudoers)  -eq 0 ]; then
echo "$uname ALL=(ALL) NOPASSWD: ALL" | sudo EDITOR='tee -a' visudo;
fi;
