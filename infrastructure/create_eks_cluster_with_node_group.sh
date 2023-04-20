#!/bin/sh
echo "Enter the name of the cluster : "
read clustername
echo "Enter the region of the cluster : "
read regioncode
eksctl create cluster --name $clustername --region $regioncode 
