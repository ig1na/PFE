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

# Master configuration
sudo kubeadm init --pod-network-cidr=10.244.0.0/16

# Use default configuration file
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

# Deploy pod network
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml

