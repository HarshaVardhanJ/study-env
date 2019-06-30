#!/bin/bash

# Download CentOS 7.1 minimal ISO
cd /tmp;
echo "Please wait for download of the CentOS 7.1 minimal ISO to complete...";
wget http://archive.kernel.org/centos-vault/7.1.1503/isos/x86_64/CentOS-7-x86_64-Minimal-1503-01.iso -nv;

# Install Apache
yum -y install httpd;

# Start and enable Apache
systemctl enable httpd;
systemctl start httpd;

# Start and enable FirewallD
systemctl enable firewalld;
systemctl start firewalld;

# Enable HTTP traffic on firewall
firewall-cmd --permanent --add-service=http;
firewall-cmd --reload;

# Mount CentOS 7.1 ISO & Correct any permissions issues
mount -o loop /tmp/CentOS-7-x86_64-Minimal-1503-01.iso /var/www/html;
restorecon -Rv /var/www/html;

# Disable all yum repositories
yum -y install yum-utils;
yum-config-manager --disable *
