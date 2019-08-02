#!/bin/bash

BOX=$1;

# Hide warnings about Python 2 on RHEL 7
PYTHONWARNINGS=ignore::UserWarning;
export PYTHONWARNINGS;

if [ -f '/tmp/retry' ]; then
  cd ~vagrant/sync/${BOX};
  ansible-playbook site.yml;
fi
