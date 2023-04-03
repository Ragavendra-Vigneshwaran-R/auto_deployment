#!/bin/bash
helm repo add kedacore https://kedacore.github.io/charts
helm repo update
kubectl create namespace keda-server
helm install keda kedacore/keda --namespace keda-server