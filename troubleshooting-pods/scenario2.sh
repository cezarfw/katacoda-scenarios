#! /bin/bash
kubectl taint nodes node01 disktype=slow:NoSchedule
kubectl delete pod --all
