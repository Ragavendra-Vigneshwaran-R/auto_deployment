#!/bin/sh
echo "Before deleting the eks cluster you have delete all services with loadbalancer and then you can delete your cluster.You can delete your services with loadbalancer using below two commands : "
echo "kubectl get svc --all-namespaces"
echo "kubectl delete svc <service-name>"
echo "Did you delete all service with loadBalancer?(Y/N)"
read answer
if [ $answer = "Y" ]
then 
    echo "Enter your cluster name : "
    read cluster_name
    echo "Enter your region code of your cluster : "
    read region_code
    eksctl delete cluster --name $cluster_name --region $region_code
else
    echo "Kindly delete the services with loadBalacer"
fi
