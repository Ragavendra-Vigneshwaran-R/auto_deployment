#!/bin/bash
###############################################################################
# Name: getkeda.sh
###############################################################################
# Description:
# To deploy keda for the required tenants
###############################################################################
# Function Declaration
###############################################################################
function exit_error {
  echo "[`date`] ${*}"
  exit 1
}

# Write message to stdout
function console_msg {
  echo "[`date`] ${*}"
}

# Usage of this script
usage() {
  echo " --namespace   - Namespce in which the deployment to be deployed"
  echo " -h|--help     - Show this help message"
  echo ""
  exit 1
}

parseArgs(){
  while test $# -ge 1; do
    arg=$1
    shift
    case $arg in
	  --namespace)
        namespace=${1}
        shift
      ;;
	  -h|--help)
        usage
      ;;
	esac
  done
  if ! [[ $namespace  ]]
  then
    console_msg "Error: Invalid Arguments"
    usage
  fi
}

#Get information on Keda
function get_keda()
{
    namespace=${1}
    echo "-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.HPA of your application.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-."
    kubectl get hpa -n $namespace
    echo "-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.Scaled Objects of your application.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-."
    kubectl get ScaledObjects -n $namespace
    echo "-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.Keda Resources of your application.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-."
    kubectl get all -n keda
}


###############################################################################
# Main Declaration
###############################################################################
# Parse input arguments
parseArgs "$@"
get_keda $namespace

