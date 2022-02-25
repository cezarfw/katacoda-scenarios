#! /bin/bash

sed 's/--trusted-ca-file=\/etc\/kubernetes\/pki\/etcd\/ca.crt/--trusted-ca-file=\/etc\/kubernetes\/pki\/etcd\/wrongca.crt/' /etc/kubernetes/manifests/etcd.yaml -i