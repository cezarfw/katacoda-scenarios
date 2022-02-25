#! /bin/bash
cd ~/manifests

kubectl delete -f kuard-1.yaml
kubectl apply -f ../webserver-1.yaml
