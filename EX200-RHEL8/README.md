# EX200-RHEL8

## Description

This provides a minimal study environment for the EX200 (RHCSA) exam based on RHEL8.

Please see Environment Overview and Environment Details below for more information.

## Exam Objectives

Exam objectives can be reviewed publicly on [the Red Hat website](https://www.redhat.com/en/services/training/ex200-red-hat-certified-system-administrator-rhcsa-exam)

## Hardware Requirements

* Virtualization capability on CPU
* libvirt (KVM) + vagrant-libvirt plugin or VirtualBox preinstalled
* SSH client (openssh on Linux/Mac, putty on Windows preferred)
* 8 GB of RAM

## Environment Overview

Several machines are provided to assist you in studying:

* `services` - This machine provides services you may need to study but should not need to setup on your own. Typically, you should not have to connect to this machine.
* `server1` & `server2` - These machines are base installs you can use to study with.

Please note there may be a management network created on each machine by Vagrant. You may use DNS or the `172.25.250.0/24` network to interact with the study environment.

## Environment Details

`server1` & `server2` provide three 5 GB pristine hard drives that may be used for storage configuration exercises (VDO, Stratis, LVM, Standard Partitions).

The `services` machine exposes an NFS server with the following exports to the `example.com` domain:

* `/shares/share1` - Exported as read-only
* `/shares/share2` - Exported as read-write

## Usage

Before launching the study environment, download the RHEL 8.0 Binary DVD ISO per the instructions in [iso/README.md](iso/README.md).

To launch the study environment, use: `vagrant up --provider=PROV` where `PROV` is either `libvirt` or `virtualbox`

To access the environment, follow the instructions provided on screen after launching the environment.

To destroy the entire study environment, use: `vagrant destroy`

To reset a specific machine (avoid resetting the `services` machine where possible), use: `vagrant destroy MACHINE && vagrant up MACHINE` where `MACHINE` is the name listed under `Environment Overview`
