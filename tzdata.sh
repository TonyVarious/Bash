#!/bin/bash
echo "Updating CentOS mirrors"
sudo sed -i 's|mirrorlist=|#mirrorlist=|g' /etc/yum.repos.d/CentOS-*.repo
sudo sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*.repo

echo "Updating tzdata"
yum clean all
yum update -y tzdata
