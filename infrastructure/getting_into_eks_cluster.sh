#!/bin/sh
echo "Enter the region code : "
read region_code
echo "Enter the cluster name : "
read cluster_name
aws eks update-kubeconfig --region $region_code --name $cluster_name
