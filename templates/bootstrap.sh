#!/usr/bin/env bash

sudo yum -y install ansible

cat > /tmp/provision-app.yml <<"EOF"
{{ provision_app }}
EOF

sudo ansible-playbook -i "localhost," -c local /tmp/provision-app.yml --extra-vars "app_version={{ app_version }}"