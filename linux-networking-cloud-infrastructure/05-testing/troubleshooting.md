# Troubleshooting guide

## SSH connection times out

Check:
- Instance is running and has a reachable address.
- Security group allows TCP 22 from your current public IP `/32`.
- Subnet route table and internet gateway are correct for public access.
- UFW permits SSH.
- Correct username and private key are used.

Client diagnostics:

```bash
ssh -vvv -i lab-key.pem ubuntu@PUBLIC_IPV4
nc -vz PUBLIC_IPV4 22
```

## Permission denied (publickey)

- Confirm correct login user (Ubuntu images commonly use `ubuntu`).
- Confirm matching key pair.
- On client: `chmod 400 lab-key.pem`.
- On server console/recovery path, inspect `~/.ssh/authorized_keys` and permissions.

## Website not reachable

On server:

```bash
sudo systemctl status nginx
sudo nginx -t
sudo ss -lntp | grep ':80'
curl -v http://127.0.0.1/
sudo ufw status verbose
sudo journalctl -u nginx -n 100 --no-pager
```

Then inspect cloud security group inbound TCP 80, subnet routing, public IP, and network ACLs.

## DNS fails but IP connectivity works

```bash
getent hosts example.com
resolvectl status
cat /etc/resolv.conf
```

Check configured DNS resolver and outbound UDP/TCP 53 policy. Do not overwrite resolver-managed files without understanding the network manager.

## Nginx returns 403 or 404

```bash
sudo nginx -T
namei -l /var/www/linux-cloud-lab/index.html
ls -l /var/www/linux-cloud-lab/
```

Check the configured document root, index filename, directory traversal permissions, and Nginx logs.
