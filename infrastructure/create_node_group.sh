#!/bin/sh
echo "Enter your cluster name : "
read cluster_name
echo "Enter your region code : "
read region_code
echo "Enter node group name : "
read node_group_name
echo "Enter node type : "
read node_type
echo "Enter the number of nodes that you want to have : "
read no_of_nodes
echo "Enter the minimum number of node :"
read min_no_of_nodes
echo "Enter the maximum number of node :"
read max_no_of_nodes
echo "Enter the  name of the ppk file for ssh purpose  :"
read ppk_file
eksctl create nodegroup \
  --cluster $cluster_name \
  --region $region_code \
  --name $node_group_name \
  --node-type $node_type \
  --nodes $no_of_nodes \
  --nodes-min $min_no_of_nodes \
  --nodes-max $max_no_of_nodes \
  --ssh-access \
  --ssh-public-key $ppk_file