# Contributing

## Basic Guidelines

* All commits should be [signed](https://help.github.com/en/articles/managing-commit-signature-verification)
* Every file should end with a blank new line. No exceptions
* Binary files should not be stored in the repository. If these are needed, write an initialization script in the Vagrantfile that downloads them or provide instructions to the user in the README.md file associated with the study environment.
* Each change should be created as a branch and submitted as a pull request
* Add your name to the AUTHORS.md file as you would like to be credited. Your name should not appear more than once in the file and should not take up more than one line
* Do not break the NDA for any exam
* Try to provide support for both libvirt and VirtualBox providers when possible

## Basic Structure

Each new exam study environment should have it's own folder created at the root of the repository. This folder should be named after the exam's SKU and associated software version. For example `EX200-RHEL7`.

Inside this folder, you should include at least the following:

* README.md - should detail usage instructions and any details specific to your environment (such as hardware requirements and a link to the exam objectives)
* Vagrantfile - should handle the setup of the VMs/environment, download any needed binary files (like ISOs), and run Ansible on each applicable machine
* One or more directories each containing a separate Ansible playbook - the playbook should perform all configuration needed on each machine

Whenever possible, you should use the provided template folder to create a new exam study environment.

## Design Notes

At minimum, each study environment should provide a `services` machine that provides services that the learner is not expected to understand to study for the relevant exam. For example, `nfs server`.

On top of the `services` machine, you may provide as many machines as needed to provide a minimal study environment.

When setting hardware requirements, you should aim to require no more than 8 GB of RAM where possible.

Each study machine should be able to resolve and reach all the other study machines.

FirewallD and SELinux should be enabled on all study machines unless Red Hat explicitly recommends publicly to disable one of them for the given exam.

FirewallD should allow ping and SSH to/from all other study machines.

SSH key-based authentication should be setup so that a user can connect to all the other study machines without using a password via SSH.

All study machines should provide a `student` user that the student will use to connect to each machine. The password for this user should also be `student`.

Users will initially connect to one of the study machines using password then SSH to other machines using the locally established SSH key.

An motd file should be provided on every machine asking the user to read the contents of a README file located in the `student` home directory of every machine. This README file should include details for any services provided by the `services` machine such as available NFS/CIFS mounts, LDAP details and usernames/passwords, etc...

You should always aim to use upstream software versions that are equivilant to the Red Hat software version being tested on. For example, `Kubernetes` instead of `OpenShift`.

When creating the Ansible playbooks for study machines, you should aim to provide a minimal environment for study. Please check the exam objectives when deciding what minimal means.

For example, if you are creating a study environment for `EX280-OCP3.9`, you would install the upstream version of `OCP3.9` (`Kubernetes`) with a minimal configuration because the given exam does not include an installation objective.

On the other hand, if you are creating a study environment for `EX125-RHCS3`, there is an installation objective so you would provide the installation media but not perform the installation.

## Pull Request Acceptance Guidelines

All incoming pull requests will be reviewed to ensure the requirements laid out in this document are adhered to.

All incoming pull requests will also be briefly tested to ensure they launch and seem to execute without errors.

Any pull request that does not meet the above will not be merged. Instead, feedback will be provided so you can correct any issues and try again.
