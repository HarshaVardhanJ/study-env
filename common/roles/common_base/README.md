# common_base role

This role sets up common configuration on all systems

## Variables

* `install_packages` - list of packages that need to be installed on the server
* `firewall_services` - list of FirewallD services to allow inbound through the firewall
* `install_ansible_version` - the version number of Ansible that should be installed (defaults to latest)
