# Contributing

## Basic Guidelines

* All commits should be [signed](https://help.github.com/en/articles/managing-commit-signature-verification)
* Every file should end with a blank new line. No exceptions
* Binary files should not be stored in the repository. If these are needed, write an initialization script in the Vagrantfile that downloads them or provide instructions to the user in the README.md file associated with the study environment.
* Each change should be created as a branch and submitted as a pull request
* Add your name to the AUTHORS.md file as you would like to be credited. Your name should not appear more than once in the file and should not take up more than one line
* Do not break the NDA for any exam
* You must support both libvirt and VirtualBox providers

## Basic Structure

Each new exam study environment should have it's own folder created at the root of the repository. This folder should be named after the exam's SKU and associated operating system version (either `RHEL7` or `RHEL8`). For example `EX200-RHEL7`.

Use one of the templates (copy it) to create a skeleton for your new environment.

Edit the `environment.yml` file appropriately and then change `study/site.yml` to use the appropriate roles passing in any variables as required.

When possible, you should use an existing role under `common/roles`. If one does not exist for your use case, you should try to create a new role named after the exam SKU (for example, `ex200`) and it should automatically detect the operating system version and support both RHEL 7 and RHEL 8 equivilants of the exam as appropriate. You can look at an existing role for ideas on how to proceed.

If you absolutely must, create a `roles` directory in the environment folder (for example, `EX200--RHEL7/roles`) and create a new role there. The directory is already in the roles path as configured in ansible.cfg.

You should avoid editing the Vagrantfiles where possible.

## Design Notes

With the exception of the base OS, you should always aim to use upstream software versions that are equivilant to the Red Hat software version being tested on. For example, `Kubernetes` instead of `OpenShift`.

When creating the Ansible playbooks and/or creating/selecting roles for study machines, you should aim to provide a minimal environment for study. Please check the exam objectives when deciding what minimal means.

For example, the `EX200-RHEL8` requires users to mount an NFS share but not a CIFS share so you should provide an NFS server (and not a Samba server) preconfigured with different shares on the `services` machine. For the study machines, there are various activites required for block devices so you may provide a couple different additional hard drives.

## Pull Request Acceptance Guidelines

All incoming pull requests will be reviewed to ensure the requirements laid out in this document are adhered to.

All incoming pull requests will also be briefly tested to ensure they launch and seem to execute without errors.

Any pull request that does not meet the above will not be merged. Instead, feedback will be provided so you can correct any issues and try again.
