#!/bin/bash

#update the package index
apt-get update

#install basic dependencies and utilities
apt-get install -y \
curl \
wget \
apt-transport-https \
dnsutils \
vim \
gnupg \
git \
build-essential \
net-tools \
iputils-ping \
unzip \
zip \
tar \
bzip2 \
gzip \
software-properties-common\
ca-certificates 

#
# apt-get clean 
# rm -rf /var/lib/apt/lists/*

#Disable all swap space 
swapoff -a

#Add Docker Official GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc

#Make script executable 
chmod a+r /etc/apt/keyrings/docker.asc

#Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  tee /etc/apt/sources.list.d/docker.list > /dev/null

#update the package index
apt-get update
 
#Install docker
apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin 
