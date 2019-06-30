# TEMPLATE-RHEL7

## Description

This is a template file meant to make it easier to create new study environments. It should not be used by end users.

## Exam Objectives

Exam objectives can be reviewed publicly on [the Red Hat website](https://www.redhat.com/en/services/training/ex200-red-hat-certified-system-administrator-rhcsa-exam)

## Hardware Requirements

* Virtualization capability on CPU
* libvirt or VirtualBox preinstalled
* 8 GB of RAM
* 40 GB disk space

## Environment Overview

Several machines are provided to assist you in studying:

* `services` - This machine provides services you may need to study but should not need to setup on your own. Typically, you should not have to connect to this machine.
* `server1` & `server2` - These machines are base installs you can use to study with.

## Usage

To launch the study environment, use: `vagrant up --provider=PROV` where `PROV` is either `libvirt` or `virtualbox`

To access the environment, follow the instructions provided on screen after launching the environment.

To destroy the study environment, use: `vagrant destroy`