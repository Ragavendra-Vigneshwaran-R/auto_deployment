#!/bin/bash
###############################################################################
# Name: deletekeda.sh
###############################################################################
# Description:
# To delete keda resource in cluster
###############################################################################
# Usage
# Run the below command for executing the script
# ./deletekeda.sh
###############################################################################
# Main Declaration
###############################################################################
kubectl delete $(kubectl get scaledobjects.keda.sh,scaledjobs.keda.sh -A \
  -o jsonpath='{"-n "}{.items[*].metadata.namespace}{" "}{.items[*].kind}{"/"}{.items[*].metadata.name}{"\n"}')
helm uninstall keda -n keda