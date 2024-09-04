#!/bin/bash

# Update the package index
apt-get update

# Install basic dependencies and utilities
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
    software-properties-common \
    openssl \
    jq \
    ca-certificates

# Disable all swap space 
swapoff -a

# Create the directory for keyrings if it doesn't exist
mkdir -p /etc/apt/keyrings

# Add Docker Official GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | tee /etc/apt/keyrings/docker.asc

# Make script executable
chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  tee /etc/apt/sources.list.d/docker.list > /dev/null

# Update the package index
apt-get update

# Install Docker
apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin
