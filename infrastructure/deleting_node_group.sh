#!/bin/sh
echo "Enter the name of your cluster : "
read cluster_name
echo "Enter the region code of your cluster : "
read region_code
echo "Enter the name of your node group : "
read node_group
eksctl delete nodegroup \
  --cluster $cluster_name \
  --region $region_code \
  --name $node_group
