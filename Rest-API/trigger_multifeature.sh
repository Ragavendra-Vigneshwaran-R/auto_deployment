#!/bin/bash
###############################################################################
# Name: trigger_multifeature.sh
###############################################################################
# Description:
# To trigger the github action which will deploy the application with keda
###############################################################################
# Usage
# Run the below command for executing the script
# ./trigger_multifeature.sh --dockerimage <dockerimage> --keda <keda> --cicd <cicd> --monitoring <monitoring> --namespace <namespace>
# For help
# ./trigger_multifeature.sh --help
# ./trigger_multifeature.sh -h
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
  echo " --dockerimage  - Docker Image"
  echo " --keda         - Enable or Disable Keda"
  echo " --cicd         - Enable or Disable CICD"
  echo " --monitoring   - Enable or Disable monitoring"
  echo " --namespace    - Namespce in which the deployment to be deployed"
  echo " -h|--help      - Show this help message"
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
      --keda)
        keda=${1}
        shift
      ;;
	  --cicd)
        cicd=${1}
        shift
      ;;
	  --monitoring)
        monitoring=${1}
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
  if ! [[ $dockerimage && $keda && $cicd && $monitoring && $namespace  ]]
  then
    console_msg "Error: Invalid Arguments"
    usage
  fi
}

function trigger_multifeature()
{
    dockerimage=${1}
    keda=${2}
    cicd=${3}
    monitoring=${4}
    namespace=${5}
    GITHUB_REPOSITORY=${6}
    GITHUB_TOKEN=${7}
    JSON="{\"ref\":\"develop\",\"inputs\":{\"dockerimage\":\"$dockerimage\",\"keda\":\"$keda\",\"cicd\":\"$cicd\",\"monitoring\":\"$monitoring\",\"namespace\":\"$namespace\"}}"
    curl -X POST \
    -H "Accept: application/vnd.github.v3+json" \
    -H "Authorization: Bearer ${GITHUB_TOKEN}" \
    https://api.github.com/repos/${GITHUB_REPOSITORY}/actions/workflows/multifeature.yml/dispatches \
    -d "$JSON"
    if [[ $? -eq 0 ]]
    then
    console_msg "INFO: Successfully triggered the deployment with keda"
    else
    exit_error "ERROR: Failed to trigger the deployment with keda"
    fi
}

###############################################################################
# Main Declaration
###############################################################################
# Parse input arguments
source .env
GITHUB_REPOSITORY=$(echo $GITHUB_REPOSITORY | base64 -d)
GITHUB_TOKEN=$(echo $GITHUB_TOKEN | base64 -d)

parseArgs "$@"
trigger_multifeature $dockerimage $keda $cicd $monitoring $namespace $GITHUB_REPOSITORY $GITHUB_TOKEN