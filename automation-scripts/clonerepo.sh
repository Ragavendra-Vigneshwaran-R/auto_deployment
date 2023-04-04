#!/bin/bash
###############################################################################
# Name: clonerepo.sh
###############################################################################
# Description:
# To clone the auto_deployment repo from develop branch in github
###############################################################################
# Usage
# Run the below command for executing the script
# ./clonerepo.sh
###############################################################################
# Main Declaration
###############################################################################
check_folder=$(cd ~/auto_deployment/)
if [ $? -eq 0 ]
then
rm -rf ~/auto_deployment/
fi
cd ~/ && git clone https://github.com/Ragavendra-Vigneshwaran-R/auto_deployment.git -b develop