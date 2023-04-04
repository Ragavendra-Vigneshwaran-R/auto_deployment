#!/bin/bash
###############################################################################
# Name: action_keda.sh
###############################################################################
# Description:
# To trigger the github action which will deploy the application with keda
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

function trigger_keda()
{
    dockerimage=${1}
    maxpods=${2}
    minpods=${3}
    metrics=${4}
    namespace=${5}
    GITHUB_REPOSITORY=${6}
    GITHUB_TOKEN=${7}
    JSON="{\"ref\":\"develop\",\"inputs\":{\"dockerimage\":\"$dockerimage\",\"maxpods\":\"$maxpods\",\"minpods\":\"$minpods\",\"metrics\":\"$metrics\",\"namespace\":\"$namespace\"}}"
    curl -X POST \
    -H "Accept: application/vnd.github.v3+json" \
    -H "Authorization: Bearer ${GITHUB_TOKEN}" \
    https://api.github.com/repos/${GITHUB_REPOSITORY}/actions/workflows/keda.yml/dispatches \
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
trigger_keda $dockerimage $maxpods $minpods $metrics $namespace $GITHUB_REPOSITORY $GITHUB_TOKEN