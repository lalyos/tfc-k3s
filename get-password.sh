#!/bin/bash

SERVER_IP=$(jq -r .server_ip)
: ${SERVER_IP:? required}

pwd=$(
  ssh -l rancher ${SERVER_IP} \
    kubectl config view -o jsonpath='{.users[0].user.password}'
)

cat <<EOF
{ "password" : "${pwd}" }
EOF