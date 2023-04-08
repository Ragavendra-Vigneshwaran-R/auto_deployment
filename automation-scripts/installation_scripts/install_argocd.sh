#!/bin/bash
###############################################################################
# Name: install_argocd.sh
###############################################################################
# Description:
# To install argocd resource in the cluster
###############################################################################
# Usage
# Run the below command for executing the script
# ./install_argocd.sh
###############################################################################
# Main Declaration
###############################################################################
function install_argocd(){
    check_argocd=$(kubectl get ns | grep -i "argocd")
    if [[ $? -eq 1 ]]
    then
    kubectl create namespace argocd
    kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
    kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'
    kubectl apply -f ~/auto_deployment/automation-scripts/installation_scripts/argocd-user.yml -n argocd
    kubectl apply -f ~/auto_deployment/automation-scripts/installation_scripts/rbac.yml -n argocd
    else
    echo "Argocd is already installed, skipping the installation process.."
    fi
}

###############################################################################
# Main Declaration
###############################################################################
install_argocd