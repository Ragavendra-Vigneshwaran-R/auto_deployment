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
check_argocd=$(kubectl get ns | grep -i "argocd")
if [[ $? -eq 1 ]]
then
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
else
echo "Argocd is already installed, skipping the installation process.."
fi
kubectl get all -n argocd
kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'
kubectl get services --namespace argocd argocd-server --output jsonpath='{.status.loadBalancer.ingress[0].ip}' | echo
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d;echo