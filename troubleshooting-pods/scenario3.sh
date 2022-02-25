#! /bin/bash
kubectl cordon node01
kubectl taint nodes node01 disktype:NoSchedule-
kubectl delete pod --all
