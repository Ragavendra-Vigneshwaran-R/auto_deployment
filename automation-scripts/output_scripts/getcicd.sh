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
argocd_endpoint=$(kubectl get services --namespace argocd argocd-server --output jsonpath='{.status.loadBalancer.ingress[0].hostname}')
argocd_username="admin"
argocd_password=$(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d)
argocd_resources=$(kubectl get all -n argocd)
echo -e "-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.ArgoCD endpoint .-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-."
echo -e "ArgoCD Endpoint : $argocd_endpoint"
echo -e "-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.ArgoCD Username .-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-."
echo -e "ArgoCD Username : $argocd_username"
echo -e "-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.ArgoCD Password .-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-."
echo -e "ArgoCD Password : $argocd_password"
echo -e "-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.ArgoCD Resources of your application .-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-."
echo -e "$argocd_resources"
echo -e "-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.Application is succesfully deployed with CICD .-.-.-.-.-.-.-.-.-.-.-.-."