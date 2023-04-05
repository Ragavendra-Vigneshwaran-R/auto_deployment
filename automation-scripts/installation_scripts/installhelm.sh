#!/bin/sh
###############################################################################
# Name: installhelm.sh
###############################################################################
# Description:
# To install helm in the cluster
###############################################################################
# Usage
# Run the below command for executing the script
# ./installhelm.sh
###############################################################################
# Main Declaration
###############################################################################
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh