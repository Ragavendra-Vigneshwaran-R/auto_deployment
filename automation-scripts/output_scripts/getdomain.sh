#!/bin/bash
###############################################################################
# Name: getkeda.sh
###############################################################################
# Description:
# To deploy keda for the required tenants
###############################################################################
# Usage
# Run the below command
# ./getdomain.sh --namespace <namespace>
# For help
# ./getdomain.sh --help
# ./getdomain.sh -h
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
function get_domain()
{
    namespace=${1}
    echo -e "-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.Domain of your application.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-."
    domain=$(kubectl get svc application-svc -o jsonpath='{.status.loadBalancer.ingress[0].hostname}' -n $namespace)
    port="3000"
    echo -e "Domain : $domain:$port"
}


###############################################################################
# Main Declaration
###############################################################################
# Parse input arguments
parseArgs "$@"
get_domain $namespace

