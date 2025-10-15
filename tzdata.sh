#!/usr/bin/env bash
set -euo pipefail

echo "[INFO] Detecting OS type..."

if [[ -f /etc/centos-release ]]; then
  echo "[INFO] CentOS detected. Updating repos to use Vault and tzdata..."

  sed -i 's|mirrorlist=|#mirrorlist=|g' /etc/yum.repos.d/CentOS-*.repo || true
  sed -i 's|#baseurl=http://mirror.centos.org|baseurl=https://vault.centos.org|g' /etc/yum.repos.d/CentOS-*.repo || true
  sed -i 's|#baseurl=https://mirror.centos.org|baseurl=https://vault.centos.org|g' /etc/yum.repos.d/CentOS-*.repo || true

  yum clean all -y
  yum makecache -y
  yum update -y tzdata

elif [[ -f /etc/debian_version ]]; then
  echo "[INFO] Debian/Ubuntu detected. Updating tzdata..."
  apt-get update -y
  DEBIAN_FRONTEND=noninteractive apt-get install --only-upgrade -y tzdata

else
  echo "[ERROR] Unsupported OS — not CentOS or Debian-based."
  exit 1
fi

echo "[INFO] Done."
