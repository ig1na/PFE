#!/bin/bash

sudo apt update

# Install Docker
sudo apt install docker.io
sudo systemctl enable docker

# Install Kubernetes
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add
sudo apt-add-repository "deb http://apt.kubernetes.io/ kubernetes-xenial main"
sudo apt install kubeadm
sudo swapoff -a

# Needed directory for Grafana service
sudo mkdir /var/lib/grafana
sudo chmod 755 /var/lib/grafana

# Needed directory for FROST service
sudo mkdir /tmp/data
sudo chmod 755 /tmp/data

# Joining the cluster
echo You are now supposed to use the kubeadm join command
