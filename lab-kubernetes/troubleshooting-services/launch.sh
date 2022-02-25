#! /bin/bash
docker pull gcr.io/kuar-demo/kuard-amd64:blue
kubectl apply -f resources.yaml
kubectl apply -f manifests/kuard-1.yaml
