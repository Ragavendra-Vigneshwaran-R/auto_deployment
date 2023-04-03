#!/bin/bash
cd ~/auto_deployment/
if [ $? -eq 0 ]
then
rm -rf ~/auto_deployment/
fi
cd ~/ && git clone https://github.com/Ragavendra-Vigneshwaran-R/auto_deployment.git -b develop