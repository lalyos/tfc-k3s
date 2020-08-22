#!/bin/bash

while ! ssh -F ssh_config k3s true 2> /dev/null ; do
  echo -n .
  sleep 1
done

cat <<EOF
{
  "password" : "$(
      ssh -F ssh_config k3s \
        kubectl config view -o jsonpath='{.users[0].user.password}'
    )"
}
EOF