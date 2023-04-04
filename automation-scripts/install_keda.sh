#!/bin/bash
###############################################################################
# Name: install_keda.sh
###############################################################################
# Description:
# To install keda resource in the cluster
###############################################################################
# Usage
# Run the below command for executing the script
# ./install_keda.sh
###############################################################################
# Main Declaration
###############################################################################
helm repo add kedacore https://kedacore.github.io/charts
helm repo update
check_keda=$(kubectl get ns | grep -i "keda")
if [[ $? -eq 1 ]]
then
kubectl create namespace keda
helm install keda kedacore/keda --namespace keda
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml
kubectl get deployment metrics-server -n kube-system
else
echo "Keda is already installed, skipping the installation process.."
fi