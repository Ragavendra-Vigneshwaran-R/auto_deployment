#!/bin/bash
###############################################################################
# Name: deploy_keda.sh
###############################################################################
# Description:
# To deploy application with keda  for the required tenants
###############################################################################
# Usage
# Run the below command for executing the script
# ./deploy_keda.sh --dockerimage <dockerimage> --maxpods <maxpods> --minpods <minpods> --metrics <metrics> --namespace <namespace>
# For help
# ./deploy_keda.sh --help
# ./deploy_keda.sh -h
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
  echo " --maxpods     - Maximum Pods needs to be allocated"
  echo " --minpods     - Minimum Pods needs to be allocated"
  echo " --metrics     - Metrics of the HPA"
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
      --maxpods)
        maxpods=${1}
        shift
      ;;
	  --minpods)
        minpods=${1}
        shift
      ;;
	  --metrics)
        metrics=${1}
        shift
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
  if ! [[ $dockerimage && $maxpods && $minpods && $metrics && $namespace  ]]
  then
    console_msg "Error: Invalid Arguments"
    usage
  fi
}

#Deploy Keda
function deploy_keda()
{
    dockerimage=${1}
    maxpods=${2}
    minpods=${3}
    metrics=${4}
    namespace=${5}
    echo "-.-.-.Deploying application with Keda.-.-.-"
    kubectl create namespace $namespace
    helm install $namespace ~/auto_deployment/deployment/ --set keda.enabled=true --set namespace=$namespace --set imageTag=$dockerimage --set keda.maxReplicaCount=$maxpods --set keda.minReplicaCount=$minpods --set keda.triggers.type=$metrics -n $namespace
    if [ $? -eq  0 ]
    then
    console_msg "INFO: Docker Image is successfully deployment with keda under the namespace" $namespace "."
    else
    console_msg "ERROR: Docker Image is failed to deploy with keda under the namespace" $namespace "."
    fi
}


###############################################################################
# Main Declaration
###############################################################################
# Parse input arguments
parseArgs "$@"
deploy_keda $dockerimage $maxpods $minpods $metrics $namespace