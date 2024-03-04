#!/bin/bash

sudo yum install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm -y
sudo yum update -y
sudo yum install git python python-level python-pip openssl ansible -y

read -p "Enter the Group Name  : " gname
echo "[$gname]" >> /etc/ansible/hosts
read -p "Enter Number of Nodes : " numnodes
for i in `seq 1 $numnodes`; do
read -p "Enter Private IP of Nodes[$i] : " node[$i-1]
echo ${node[$i-1]} >> /etc/ansible/hosts; done

sed -i 's/#inventory[[:space:]]/inventory /g' /etc/ansible/ansible.cfg
sed -i 's/#sudo_user[[:space:]]/sudo_user /g' /etc/ansible/ansible.cfg

read -p "Enter the Username Name to connect : " uname

runuser -u $uname ssh-keygen
for i in `seq 1 $numnodes`; do
runuser -u $uname ssh-copy-id $uname@${node[$i-1]};
done
