#!/bin/bash
###############################################################################
# Name: install_monitoring.sh
###############################################################################
# Description:
# To install monitoring(kube-prometheus-stack) resource in the cluster
###############################################################################
# Usage
# Run the below command for executing the script
# ./install_monitoring.sh
###############################################################################
# Main Declaration
###############################################################################
check_monitoring=$(kubectl get ns | grep -i "monitoring")
if [[ $? -eq 1 ]]
then
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
kubectl create namespace monitoring
helm install prometheus prometheus-community/kube-prometheus-stack -n monitoring
kubectl patch svc prometheus-kube-prometheus-prometheus -n monitoring -p '{"spec": {"type": "LoadBalancer"}}'
kubectl patch svc prometheus-grafana -n monitoring -p '{"spec": {"type": "LoadBalancer"}}'
if [[ $? -eq 1 ]]
then
echo "Monitoring is successfully  installed for the application"
fi
else
echo "Monitoring already installed, skipping the installation process.."
fi