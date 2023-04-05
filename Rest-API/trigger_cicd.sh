#!/bin/bash
###############################################################################
# Name: trigger_cicd.sh
###############################################################################
# Description:
# To trigger the github action which will deploy the application with monitoring
###############################################################################
# Usage
# Run the below command for executing the script
# ./trigger_cicd.sh --dockerimage <dockerimage> --namespace <namespace>
# For help
# ./trigger_cicd.sh --help
# ./trigger_cicd.sh -h
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

function trigger_cicd()
{
    dockerimage=${1}
    namespace=${2}
    GITHUB_REPOSITORY=${3}
    GITHUB_TOKEN=${4}
    JSON="{\"ref\":\"develop\",\"inputs\":{\"dockerimage\":\"$dockerimage\",\"namespace\":\"$namespace\"}}"
    curl -X POST \
    -H "Accept: application/vnd.github.v3+json" \
    -H "Authorization: Bearer ${GITHUB_TOKEN}" \
    https://api.github.com/repos/${GITHUB_REPOSITORY}/actions/workflows/cicd.yml/dispatches \
    -d "$JSON"
}

###############################################################################
# Main Declaration
###############################################################################
# Parse input arguments
source .env
GITHUB_REPOSITORY=$(echo $GITHUB_REPOSITORY | base64 -d)
GITHUB_TOKEN=$(echo $GITHUB_TOKEN | base64 -d)
parseArgs "$@"
trigger_cicd $dockerimage $namespace $GITHUB_REPOSITORY $GITHUB_TOKEN