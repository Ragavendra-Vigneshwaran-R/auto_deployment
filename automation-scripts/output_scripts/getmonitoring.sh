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
prometheus_endpoint=$(echo -e $prometheus_url:$prometheus_port)
grafana_endpoint=$(kubectl get svc prometheus-grafana -o jsonpath='{.status.loadBalancer.ingress[0].hostname}' -n monitoring)
grafana_username="admin"
grafana_pass="cHJvbS1vcGVyYXRvcgo="
grafana_password=$(echo  -e $grafana_pass | base64 -d)
echo -e "-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.Pometheus endpoint .-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-."
echo -e "Prometheus Endpoint : $prometheus_endpoint"
echo -e "-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.Grafana endpoint .-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-."
echo -e "Grafana Endpoint : $grafana_endpoint"
echo -e "-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.Grafana Username .-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-."
echo -e "Grafana Username : $grafana_username"
echo -e "-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.Grafana Password .-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-."
echo -e "Grafana Password : $grafana_password"
echo -e "-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.Application is succesfully deployed with monitoring .-.-.-.-.-.-.-.-.-.-.-.-."
