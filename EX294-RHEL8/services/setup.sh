#!/bin/bash

# Mount ISO temporarily
mount -o loop ~vagrant/sync/iso/rhel-8.0-x86_64-dvd.iso /mnt;

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
