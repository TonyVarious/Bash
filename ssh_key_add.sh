#!/usr/bin/env bash
set -euo pipefail

# >>> REPLACE THIS WITH THE REAL KEY <<<
PUBKEY="ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJ27bVsy+rlPfD5OihHQZN3gZX18Y5BWHgO05aIBf3HN dmytro.qoders"
# <<< END >>>

ROOT_HOME="/root"
SSH_DIR="${ROOT_HOME}/.ssh"
AUTH_KEYS="${SSH_DIR}/authorized_keys"

mkdir -p "${SSH_DIR}"
chmod 700 "${SSH_DIR}"
chown root:root "${SSH_DIR}"

touch "${AUTH_KEYS}"
chmod 600 "${AUTH_KEYS}"
chown root:root "${AUTH_KEYS}"

# Add only if missing
if ! grep -qxF "${PUBKEY}" "${AUTH_KEYS}"; then
  echo "${PUBKEY}" >> "${AUTH_KEYS}"
fi

# For CentOS with SELinux
if command -v restorecon >/dev/null 2>&1; then
  restorecon -R "${SSH_DIR}" || true
fi
