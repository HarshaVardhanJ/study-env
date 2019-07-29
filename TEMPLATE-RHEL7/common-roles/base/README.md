# Base role

## Variables

* `hostname` - FQDN for the host. Defaults to `unnamed.example.com`.
* `required_packages` - a comprehensive list of all packages that need to be installed on the server. Defaults to `vim, chrony, bash-completion`
* `firewall_services` - a comprehensive list of all FirewallD services to allow inbound through the firewall. Defaults to `ssh`.
