# Base role

## Variables

* `hostname` - FQDN for the host.
* `required_packages` - a comprehensive list of all packages that need to be installed on the server
* `firewall_services` - a comprehensive list of all FirewallD services to allow inbound through the firewall
* `server_list` - a comprehensive list of all servers included in the environment
* `ansible_install_version` - the version number of Ansible that should be installed (defaults to latest)
