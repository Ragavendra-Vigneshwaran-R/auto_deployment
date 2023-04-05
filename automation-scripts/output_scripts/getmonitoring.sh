#!/bin/bash
###############################################################################
# Name: getmonitoring.sh
###############################################################################
# Description:
# To get the monitoring resources in the cluster for the required tenants
###############################################################################
# Usage
# Run the below command for executing the script
# ./getmonitoring.sh
###############################################################################
# Main Declaration
###############################################################################
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
