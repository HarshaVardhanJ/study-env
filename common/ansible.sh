#!/bin/bash

BOX=$1;

# Hide warnings about Python 2 on RHEL 7
PYTHONWARNINGS=ignore::UserWarning;
export PYTHONWARNINGS;

cd ~vagrant/sync/${BOX};
mv ~vagrant/common/roles ~vagrant;
mv ~vagrant/common/* .;
chown -R vagrant:vagrant ~vagrant;

ansible-playbook site.yml;
