#!/bin/bash

ISO=$1;
NUM=$2;

# Detect OS version
VERSION=$(grep VERSION_ID /etc/os-release | cut -d\" -f2);

# Mount ISO temporarily
mount -o loop ~vagrant/iso/${ISO} /mnt;

# Create local repository
rm -rf /var/www/html/*;

if [[ "$VERSION" == "7.0" ]]; then
  # RHEL 7
  mkdir -p /var/www/html;
  cp -ar /mnt/Packages /var/www/html;
  createrepo -v /var/www/html;
else
  # RHEL 8
  mkdir -p /var/www/html/BaseOS;
  cp -ar /mnt/BaseOS/Packages /var/www/html/BaseOS;
  createrepo -v /var/www/html/BaseOS;
  mkdir -p /var/www/html/AppStream;
  cp -ar /mnt/AppStream/Packages /var/www/html/AppStream;
  createrepo -v /var/www/html/AppStream;
fi

# Restore SELinux contexts
restorecon -Rv /var/www/html;

# Cleanup
umount /mnt;

# Generate list of servers
for ((i = 1; i <= ${NUM}; i++)); do 
  echo server${i}.example.com >> /var/www/html/servers.txt;
done

# Bootstrap dnsmasq config
cat << EOF > /etc/dnsmasq.d/localdns.conf
domain=example.com
addn-hosts=/etc/hosts.example.com
EOF

# Install dnsmasq zone
echo '172.25.250.10 services.example.com' > /etc/hosts.example.com;

for ((i = 1; i <= ${NUM}; i++)); do
  IP=$(($NUM+10))
  echo "172.25.250.${IP} server${i}.example.com" >> /etc/hosts.example.com;
done

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

# Setup FirewallD
firewall-cmd --permanent --add-service http;
firewall-cmd --permanent --add-service dns;
firewall-cmd --permanent --add-service ntp;
firewall-cmd --reload;
