#! /bin/bash
kubectl uncordon node01
kubectl delete pod kuard
cd ~/manifests

kubectl apply -f webserver.yaml