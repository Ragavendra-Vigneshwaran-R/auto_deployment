#!/bin/bash
###############################################################################
# Name: generate_argocd_token.sh
###############################################################################
# Description:
# To generate token for the argocd token
###############################################################################
# Usage
# Run the below command for executing the script
# ./generate_argocd_token.sh --username <username> --password <password> --serverurl <serverurl>
# For help
# ./generate_argocd_token.sh --help
# ./generate_argocd_token.sh -h
###############################################################################
# Main Declaration
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
  echo " --username  - Username of the argocd"
  echo " --password  - Password of the argocd"
  echo " --serverurl - Server URL of the argocd"
  echo " -h|--help   - Show this help message"
  echo ""
  exit 1
}

parseArgs(){
  while test $# -ge 1; do
    arg=$1
    shift
    case $arg in
      --username)
        username=${1}
      ;;
	  --password)
        password=${1}
        shift
      ;;
	  --serverurl)
        serverurl=${1}
        shift
      ;;
	  -h|--help)
        usage
      ;;
	esac
  done
  if ! [[ $username && $password && $serverurl ]]
  then
    console_msg "Error: Invalid Arguments"
    usage
  fi
}

function install_argocd_cli()
{
    curl -sSL -o /usr/local/bin/argocd https://github.com/argoproj/argo-cd/releases/download/v2.15.1/argocd-linux-amd64
    chmod +x /usr/local/bin/argocd
}
function generate_token()
{
    username=${1}
    password=${2}
    serverurl=${3}
    argocd login $serverurl --username $username --password $password --insecure
    token=$(argocd account generate-token --account $username)
    echo "$token"


}

###############################################################################
# Main Declaration
###############################################################################
# Parse input arguments
parseArgs "$@"
install_argocd_cli
generate_token $username $password $serverurl