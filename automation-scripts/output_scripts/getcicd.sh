#!/bin/bash
###############################################################################
# Name: getcicd.sh
###############################################################################
# Description:
# To get the cicd resources in the cluster for the required tenants
###############################################################################
# Usage
# Run the below command for executing the script
# ./getcicd.sh
###############################################################################
# Main Declaration
###############################################################################
argocd_endpoint=$(kubectl get services --namespace argocd argocd-server --output jsonpath='{.status.loadBalancer.ingress[0].ip}')
argocd_username="admin"
argocd_password=$(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d)
argocd_resources=$(kubectl get all -n argocd)
echo "-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.ArgoCD endpoint .-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-."
echo "ArgoCD Endpoint : $argocd_endpoint"
echo "-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.ArgoCD Username .-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-."
echo "ArgoCD Username : $argocd_username"
echo "-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.ArgoCD Password .-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-."
echo "ArgoCD Password : $argocd_password"
echo "-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.ArgoCD Resources of your application .-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-."
echo "$argocd_resources"
echo "-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.Application is succesfully deployed with monitoring .-.-.-.-.-.-.-.-.-.-.-.-."