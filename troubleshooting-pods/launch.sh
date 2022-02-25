#!/bin/bash
while true; do
    NUM_READY=`kubectl get nodes 2> /dev/null | grep -v NAME | awk '{print $2}' | grep -e ^Ready | wc -l`
    if [ "${NUM_READY}" == "2" ]; then
        echo "Ready" > /root/ready
        break
    else
        echo "Waiting for all Kubernetes nodes to be ready. Current ready nodes: ${NUM_READY}"
        kubectl get nodes
    fi
    sleep 