# EX407-RHEL7

## Description

This provides a minimal study environment for the EX407 exam based on RHEL7.

Please see Environment Overview and Environment Details below for more information.

## Exam Objectives

Exam objectives can be reviewed publicly on [the Red Hat website](https://www.redhat.com/en/services/training/ex407-red-hat-certified-specialist-in-ansible-automation-exam)

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

Ansible 2.7.12 is preinstalled on all servers and can be used for practice.

Each study machine has multiple additional hard drives configured. Use `lsblk` to see the full list of additional hard drives.

The `student` user has passwordless sudo access and ssh key access to all servers.

## Usage

Before launching the study environment, download the RHEL 7.0 Binary DVD ISO per the instructions in [../common/iso/README.md](../common/iso/README.md).

To launch the study environment, use: `vagrant up --provider=PROV` where `PROV` is either `libvirt` or `virtualbox`

To access the environment, follow the instructions provided on screen after launching the environment.

To destroy the entire study environment, use: `vagrant destroy`

To reset a specific machine (avoid resetting the `services` machine where possible), use: `vagrant destroy MACHINE && vagrant up MACHINE` where `MACHINE` is the name listed under `Environment Overview`
