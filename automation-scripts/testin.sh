#! /bin/bash
###############################################################################
# Name: getkeda.sh
###############################################################################
# Description:
# To deploy keda for the required tenants
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
  echo " --sharedIP   -  EC2 instance login IP"
  echo " --sharedName -  EC2 login name"
  echo " -h|--help    - Show this help message"
  echo ""
  exit 1
}

parseArgs(){
  while test $# -ge 1; do
    arg=$1
    shift
    case $arg in
	  --sharedIP)
        sharedIP=${1}
      ;;
	  --sharedName)
        sharedName=${1}
        shift
      ;;
	  -h|--help)
        usage
      ;;
	esac
  done
  if ! [[ $sharedIP && $sharedName  ]]
  then
    console_msg "Error: Invalid Arguments"
    usage
  fi
}

#Get information on Keda
function print_ip()
{
    echo ${1}@${2}
}


###############################################################################
# Main Declaration
###############################################################################
# Parse input arguments
parseArgs "$@"
print_ip $sharedName $sharedIP