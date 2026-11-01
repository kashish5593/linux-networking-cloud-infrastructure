# UFW host firewall

On a remote machine, permit SSH before enabling the firewall.

```bash
sudo apt update
sudo apt install -y ufw
sudo ufw allow OpenSSH
sudo ufw allow 80/tcp
sudo ufw status verbose
sudo ufw enable
sudo ufw status numbered
```

If the OpenSSH profile is unavailable, use `sudo ufw allow 22/tcp`. Restrict SSH to your known client IP where practical:

```bash
sudo ufw allow from YOUR_PUBLIC_IP to any port 22 proto tcp
```

Do not add both a broad SSH rule and a restricted rule unless you intend both. Remove an unwanted rule using its number from `sudo ufw status numbered`:

```bash
sudo ufw delete RULE_NUMBER
```

Verify SSH in a second session before ending the current session. UFW rules are only one layer; cloud security groups and network ACLs also apply.
