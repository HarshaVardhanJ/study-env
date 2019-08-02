#!/bin/bash

BOX=$1;

PYTHONWARNINGS=ignore::UserWarning;
export PYTHONWARNINGS;

if [ -f '/tmp/retry' ]; then
  cd ~vagrant/sync/${BOX};
  ansible-playbook site.yml;
fi
