#!/bin/bash
###############################################################################
# Name: trigger_monitoring.sh
###############################################################################
# Description:
# To trigger the github action which will deploy the application with monitoring
###############################################################################
# Usage
# Run the below command for executing the script
# ./trigger_monitoring.sh --dockerimage <dockerimage> --namespace <namespace>
# For help
# ./trigger_monitoring.sh --help
# ./trigger_monitoring.sh -h
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

function trigger_monitoring()
{
    dockerimage=${1}
    namespace=${2}
    GITHUB_REPOSITORY=${3}
    GITHUB_TOKEN=${4}
    JSON="{\"ref\":\"develop\",\"inputs\":{\"dockerimage\":\"$dockerimage\",\"namespace\":\"$namespace\"}}"
    curl -X POST \
    -H "Accept: application/vnd.github.v3+json" \
    -H "Authorization: Bearer ${GITHUB_TOKEN}" \
    https://api.github.com/repos/${GITHUB_REPOSITORY}/actions/workflows/monitoring.yml/dispatches \
    -d "$JSON"
    if [[ $? -eq 0 ]]
    then
    console_msg "INFO: Successfully triggered the deployment with monitoring"
    else
    exit_error "ERROR: Failed to trigger the deployment with monitoring"
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
trigger_monitoring $dockerimage $namespace $GITHUB_REPOSITORY $GITHUB_TOKEN