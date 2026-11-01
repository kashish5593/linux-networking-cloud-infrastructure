#!/usr/bin/env bash
# Read-only diagnostics for Ubuntu Linux server.
set -u

echo "=== OS ==="
cat /etc/os-release | sed -n '1,8p'
echo
echo "=== Host ==="
hostnamectl 2>/dev/null || hostname
echo
echo "=== Addresses ==="
ip -br address
echo
echo "=== Routes ==="
ip route
echo
echo "=== Disk ==="
df -h
echo
echo "=== Memory ==="
free -h
echo
echo "=== Listening TCP/UDP sockets ==="
sudo ss -lntup
echo
echo "=== Nginx ==="
if systemctl is-active --quiet nginx; then
  echo "nginx: active"
else
  echo "nginx: not active or not installed"
fi
echo
echo "=== Local HTTP ==="
curl --max-time 5 -sS -I http://127.0.0.1/ || true
