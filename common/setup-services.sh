#!/bin/bash

ISO=$1;
NUM=$2;

# Mount ISO temporarily
mount -o loop ~vagrant/iso/${ISO} /mnt;

# Create local repository
rm -rf /var/www/html/*;
mkdir -p /var/www/html/BaseOS;
cp -ar /mnt/BaseOS/Packages /var/www/html/BaseOS;
createrepo -v /var/www/html/BaseOS;
mkdir -p /var/www/html/AppStream;
cp -ar /mnt/AppStream/Packages /var/www/html/AppStream;
createrepo -v /var/www/html/AppStream;
restorecon -Rv /var/www/html;

# Cleanup
umount /mnt;

# Generate list of servers
for ((i = 1; i <= ${NUM}; i++)); do 
  echo server${i}.example.com >> /var/www/html/servers.txt;
done;

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

# Setup dnsmasq overrides
mkdir -p /etc/systemd/system/dnsmasq.service.d;
cat << EOF > /etc/systemd/system/dnsmasq.service.d/override.conf
[Unit]
After=network-online.target
Wants=network-online.target
EOF

# Reload systemd
systemctl daemon-reload;

# Start and enable httpd
systemctl enable httpd;
systemctl start httpd;

# Start and enable dnsmasq
systemctl enable dnsmasq;
systemctl start dnsmasq;

# Set temporary hostname
hostnamectl set-hostname services;
