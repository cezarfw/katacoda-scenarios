#!/bin/bash

set +v # suppress echoing the echo command being invoked
clear
echo "Please wait a moment while we apply some deployments to the frontend namespace.."
kubectl create -f ~/label-deploy.yaml
