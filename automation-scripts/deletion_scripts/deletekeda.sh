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
function exit_error {
  echo "[`date`] ${*}"
  exit 1
}

# Write message to stdout
function console_msg {
  echo "[`date`] ${*}"
}

kubectl delete $(kubectl get scaledobjects.keda.sh,scaledjobs.keda.sh -A \
  -o jsonpath='{"-n "}{.items[*].metadata.namespace}{" "}{.items[*].kind}{"/"}{.items[*].metadata.name}{"\n"}')
helm uninstall keda -n keda
kubectl delete ns keda
if [[ $? -eq 0 ]]
then
console_msg "INFO: Successfully deleted keda"
else
exit_error "ERROR: Failed to delete keda"
fi