#!/bin/bash
sudo ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -i "/mnt/c/Users/Dell/Downloads/auto-deployment.pem"  ubuntu@3.16.75.122 "/home/ubuntu/auto_deployment/automation-scripts/deploy_keda.sh --dockerimage $dockerimage --maxpods $maxpods --minpods $minpods --metrics $metrics --namespace $namespace"
