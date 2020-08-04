#!/usr/bin/env bash

command -v kubectl >/dev/null 2>&1 || exit 0

: ${ctx:=k3s-tf}
: ${server_ip? reuired}
: ${admin_password? reuired}

kubectl config set-context ${ctx} \
  --cluster=${ctx} --user=${ctx}admin \
&& kubectl config set-cluster ${ctx} \
  --server=https://${server_ip}:6443 \
  --insecure-skip-tls-verify \
&& kubectl config set-credentials ${ctx}admin \
  --username=admin \
  --password=${admin_password}