#!/bin/bash
###############################################################################
# Name: getkeda.sh
###############################################################################
# Description:
# To deploy keda for the required tenants
###############################################################################
# Usage
# Run the below command
# ./getkeda.sh --namespace <namespace>
# For help
# ./getkeda.sh --help
# ./getkeda.sh -h
###############################################################################
# Function Declaration
###############################################################################
function exit_error {
  echo -e "[`date`] ${*}"
  exit 1
}

# Write message to stdout
function console_msg {
  echo -e "[`date`] ${*}"
}

# Usage of this script
usage() {
  echo -e " --namespace   - Namespce in which the deployment to be deployed"
  echo -e " -h|--help     - Show this help message"
  echo -e ""
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
    sleep 120
    echo -e "-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.HPA of your application.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-."
    kubectl get hpa -n $namespace
    echo -e "-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.Scaled Objects of your application.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-."
    kubectl get ScaledObjects -n $namespace
    echo -e "-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.Keda Resources of your application.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-."
    kubectl get all -n keda
    echo -e "-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.Application is succesfully deployed with Keda .-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-."
}


###############################################################################
# Main Declaration
###############################################################################
# Parse input arguments
parseArgs "$@"
get_keda $namespace

