#!/bin/bash
###############################################################################
# Name: deploy_cicd.sh
###############################################################################
# Description:
# To deploy application with monitoring for the required tenants
###############################################################################
# Usage
# Run the below command for executing the script
# ./deploy_cicd.sh --dockerimage <dockerimage> --namespace <namespace>
# For help
# ./deploy_cicd.sh --help
# ./deploy_cicd.sh -h
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
function deploy_cicd()
{
  dockerimage=${1}
  namespace=${2}
  sleep 100
  argocd_endpoint=$(kubectl get services --namespace argocd argocd-server --output jsonpath='{.status.loadBalancer.ingress[0].hostname}')
  argocd_username="admin"
  argocd_password=$(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d)
  argocd_token=$(~/auto_deployment/automation-scripts/deployment_scripts/generate_argocd_token.sh --username $argocd_username --password $argocd_password --serverurl $argocd_endpoint)
  sed -i "s/my-namespace/$namespace/g" ~/auto_deployment/automation-scripts/deployment_scripts/app-spec.json
  sed -i "s/my-dockerimage/$dockerimage/g" ~/auto_deployment/automation-scripts/deployment_scripts/app-spec.json
  curl -X POST \
  -H "Authorization: Bearer $argocd_token" \
  -H "Content-Type: application/json" \
  -d @/home/ubuntu/auto_deployment/automation-scripts/deployment_scripts/app-spec.json \
  https://$argocd_endpoint/api/v1/applications
  if [[ $? -eq 0 ]]
  then
  echo "-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.Application is succesfully deployed with CICD .-.-.-.-.-.-.-.-.-.-.-.-."
  else
  echo "-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.ERROR: Application is failed to deployed with CICD .-.-.-.-.-.-.-.-.-.-.-.-."
  fi
  sed -i "s/$namespace/my-namespace/g" ~/auto_deployment/automation-scripts/deployment_scripts/app-spec.json
  sed -i "s/$dockerimage/my-dockerimage/g" ~/auto_deployment/automation-scripts/deployment_scripts/app-spec.json
  curl -X DELETE \
    -H "Authorization: $argocd_token" \
    https://$argocd_endpoint/api/v1/session
  if [[ $? -eq 0 ]]
  then
  echo "INFO: Successfully deleted the argocd token"
  else
  echo "ERROR: Failed to delete the argocd token"
  fi
}


###############################################################################
# Main Declaration
###############################################################################
# Parse input arguments
parseArgs "$@"
deploy_cicd $dockerimage $namespace