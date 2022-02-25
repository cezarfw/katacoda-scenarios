#! /bin/bash

sed 's/--trusted-ca-file=\/etc\/kubernetes\/pki\/etcd\/wrongca.crt/--trusted-ca-file=\/etc\/kubernetes\/pki\/etcd\/ca.crt/' /etc/kubernetes/manifests/etcd.yaml -i

systemctl stop kubelet

docker kill $(docker ps | awk '/k8s_POD_kube-apiserver*/ {print $1}')
docker kill $(docker ps | awk '/k8s_kube-apiserver*/ {print $1}')