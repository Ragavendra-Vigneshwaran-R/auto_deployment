#!/bin/bash
###############################################################################
# Name: deploy_monitoring.sh
###############################################################################
# Description:
# To deploy application with monitoring for the required tenants
###############################################################################
# Usage
# Run the below command for executing the script
# ./deploy_monitoring.sh --dockerimage <dockerimage> --namespace <namespace>
# For help
# ./deploy_monitoring.sh --help
# ./deploy_monitoring.sh -h
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
  echo " --dockerimage - Docker Image"
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
      --dockerimage)
        dockerimage=${1}
      ;;
	  --namespace)
        namespace=${1}
        shift
      ;;
	  -h|--help)
        usage
      ;;
	esac
  done
  if ! [[ $dockerimage && $namespace  ]]
  then
    console_msg "Error: Invalid Arguments"
    usage
  fi
}

#Deploy Keda
function deploy_monitoring()
{
    dockerimage=${1}
    namespace=${2}
    echo "-.-.-.Deploying application with monitoring.-.-.-"
    kubectl create namespace $namespace
    helm install $namespace ~/auto_deployment/deployment/ --set keda.enabled=false --set imageTag=$dockerimage -n $namespace
    if [ $? -eq  0 ]
    then
    console_msg "INFO: Docker Image is successfully deployment under the namespace" $namespace "."
    else
    console_msg "ERROR: Docker Image is failed to deploy under the namespace" $namespace "."
    fi
}


###############################################################################
# Main Declaration
###############################################################################
# Parse input arguments
parseArgs "$@"
deploy_monitoring $dockerimage $namespace