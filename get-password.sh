#!/bin/bash
cat <<EOF
{
  "password" : "$(
      ssh -F ssh_config k3s \
        kubectl config view -o jsonpath='{.users[0].user.password}'
    )"
}
EOF