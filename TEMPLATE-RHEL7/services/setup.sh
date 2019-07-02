#!/bin/bash

# Install pre-requisites
yum -y install wget createrepo;

# Download CentOS 7.0 ISO
cd /tmp;
echo "Please wait for download of the CentOS 7.0 ISO to complete...";
wget http://archive.kernel.org/centos-vault/7.0.1406/isos/x86_64/CentOS-7.0-1406-x86_64-Everything.iso -nv;

# Mount CentOS 7.0 ISO temporarily
mount -o loop /tmp/CentOS-7.0-1406-x86_64-Everything.iso /mnt;

# Install Apache
yum -y install httpd;

# Create local repository
rm -rf /var/www/html/*;
cp -ar /mnt/Packages /var/www/html;
createrepo -v /var/www/html;
restorecon -Rv /var/www/html;

# Cleanup
umount /mnt;
rm -rf /tmp/CentOS-7.0-1406-x86_64-Everything.iso;

# Install dnsmasq
yum -y install dnsmasq bind-utils;

# Bootstrap dnsmasq config
cat << EOF > /etc/dnsmasq.d/localdns.conf
domain=example.com
addn-hosts=/etc/hosts.example.com
EOF

# Install dnsmasq zone
cat << EOF > /etc/hosts.example.com
172.25.250.10 services.example.com
172.25.250.11 server1.example.com
172.25.250.12 server2.example.com
EOF

# Start and enable httpd
systemctl enable httpd;
systemctl start httpd;

# Start and enable dnsmasq
systemctl enable dnsmasq;
systemctl start dnsmasq;

