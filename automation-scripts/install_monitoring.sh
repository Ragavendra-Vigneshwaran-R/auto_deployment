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
sleep 200
prometheus_url=$(kubectl get svc prometheus-kube-prometheus-prometheus -o jsonpath='{.status.loadBalancer.ingress[0].hostname}' -n monitoring)
prometheus_port="9090"
prometheus_endpoint=$(echo $prometheus_url:$prometheus_port)
grafana_endpoint=$(kubectl get svc prometheus-grafana -o jsonpath='{.status.loadBalancer.ingress[0].hostname}' -n monitoring)
grafana_username="admin"
grafana_pass="cHJvbS1vcGVyYXRvcgo="
grafana_password=$(echo $grafana_pass | base64 -d)
echo "-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.Pometheus endpoint .-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-."
echo "Prometheus Endpoint : $prometheus_endpoint"
echo "-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.Grafana endpoint .-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-."
echo "Grafana Endpoint : $grafana_endpoint"
echo "-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.Grafana Username .-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-."
echo "Grafana Username : $grafana_username"
echo "-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.Grafana Password .-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-."
echo "Grafana Password : $grafana_password"
echo "-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.Application is succesfully deployed with monitoring .-.-.-.-.-.-.-.-.-.-.-.-."