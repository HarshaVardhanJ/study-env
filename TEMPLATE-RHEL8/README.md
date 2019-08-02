# TEMPLATE-RHEL8

## Description

This is a template file meant to make it easier to create new study environments. It should not be used by end users.

## Exam Objectives

Exam objectives can be reviewed publicly on [the Red Hat website](https://www.redhat.com/en/services/training/ex200-red-hat-certified-system-administrator-rhcsa-exam)

## Hardware Requirements

* Virtualization capability on CPU
* libvirt (KVM) + vagrant-libvirt plugin or VirtualBox preinstalled
* SSH client (openssh on Linux/Mac, putty on Windows preferred)
* 8 GB of RAM

## Environment Overview

Several machines are provided to assist you in studying:

* `services` - This machine provides services you may need to study but should not need to setup on your own. Typically, you should not have to connect to this machine
* One or more servers you can use to study. A full listing will be provided in the MOTD on each server

Please note there may be a management network created on each machine by Vagrant. You may use DNS or the `172.25.250.0/24` network to interact with the study environment.

## Environment Details

Details about the environment should go here. For example, exported NFS shares, ldap logins, etc...

## Usage

Before launching the study environment, download the RHEL 8.0 Binary DVD ISO per the instructions in [../common/iso/README.md](../common/iso/README.md).

To launch the study environment, use: `vagrant up --provider=PROV` where `PROV` is either `libvirt` or `virtualbox`

To access the environment, follow the instructions provided on screen after launching the environment.

To destroy the entire study environment, use: `vagrant destroy`

To reset a specific machine (avoid resetting the `services` machine where possible), use: `vagrant destroy MACHINE && vagrant up MACHINE` where `MACHINE` is the name listed under `Environment Overview`
