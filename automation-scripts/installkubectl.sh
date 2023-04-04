#!/bin/sh
###############################################################################
# Name: installkubectl.sh
###############################################################################
# Description:
# To install kubectl in the cluster
###############################################################################
# Usage
# Run the below command for executing the script
# ./installkubectl.sh
###############################################################################
# Main Declaration
###############################################################################
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
kubectl version --client
kubectl version --client --output=yaml 