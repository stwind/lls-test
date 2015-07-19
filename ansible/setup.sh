#!/bin/bash

ansible-playbook ansible/playbooks/site.yml \
    -i ansible/hosts/qc \
    -u root
