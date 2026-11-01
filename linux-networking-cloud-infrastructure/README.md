# Linux, Networking & Cloud Infrastructure

A hands-on infrastructure project that builds, secures, deploys, and verifies an Ubuntu Linux web server. The project covers Linux administration, TCP/IP networking, DNS, SSH, firewalls, AWS EC2, Nginx, and troubleshooting.

> **Status:** Lab guide and deployment assets. Complete the exercises in your own VM/cloud account and add your own evidence in `screenshots/`. Do not claim deployment is complete until you have run and verified it.

## Architecture

```text
Laptop / Browser
      |
   Internet
      |
AWS Security Group (22 from your IP; 80/443 as required)
      |
Ubuntu EC2 / Ubuntu VM
      |
UFW host firewall
      |
Nginx :80
      |
/var/www/linux-cloud-lab/index.html
```

## Learning objectives

- Navigate Linux, inspect files, storage, memory, and system information.
- Create users/groups and manage ownership and permissions.
- Inspect and manage processes and systemd services.
- Understand IPv4, CIDR, routes, DNS, TCP/UDP, and ports.
- Configure SSH public-key authentication safely.
- Configure UFW and cloud security groups using least privilege.
- Provision an Ubuntu VM or AWS EC2 instance.
- Install Nginx, deploy a static page, and verify it locally and remotely.
- Troubleshoot failures using logs and network tools.

## Repository map

| Path | Purpose |
|---|---|
| `01-linux-basics/` | CLI, users, groups, permissions, processes, services |
| `02-networking/` | IP/CIDR, routes, DNS, ports, connectivity |
| `03-security/` | SSH, UFW, cloud security groups |
| `04-cloud-deployment/` | VM/EC2 provisioning and Nginx deployment |
| `05-testing/` | Verification checklist and troubleshooting |
| `scripts/` | Repeatable deployment and diagnostics scripts |
| `web/` | Static website content |
| `screenshots/` | Your real lab evidence (add after completing) |

## Prerequisites

- Ubuntu Server 22.04/24.04 (or a compatible Ubuntu release).
- A local VirtualBox VM **or** an AWS account with permission to create EC2, key pairs, security groups, and instances.
- SSH client, Git, and a browser.
- For AWS: an Ubuntu AMI, a key pair, and a security group.
- Basic terminal familiarity.

## Quick start: local Ubuntu VM

1. Create an Ubuntu Server VM (suggested lab sizing: 2 vCPU, 2 GB RAM, 20 GB disk).
2. During installation, create a non-root user and enable OpenSSH Server.
3. Log in at the VM console and identify its IP:

   ```bash
   ip -br addr
   ip route
   ```

4. Update packages and install tools:

   ```bash
   sudo apt update
   sudo apt upgrade -y
   sudo apt install -y openssh-server curl dnsutils iproute2 netcat-openbsd
   sudo systemctl enable --now ssh
   ```

5. From your host, connect using `ssh username@VM_IP`. VirtualBox networking must allow host-to-guest access (bridged networking or a configured NAT port-forward).

## Quick start: AWS EC2

1. Launch an Ubuntu Server EC2 instance in a subnet with a route to the internet. A public IPv4 address is needed for direct public access.
2. Create/select an SSH key pair and download its private key once.
3. Attach a security group with:
   - TCP 22 from **your current public IP `/32` only**.
   - TCP 80 from `0.0.0.0/0` only if the website should be public.
   - TCP 443 from `0.0.0.0/0` only after HTTPS is configured.
4. Connect (replace the placeholders):

   ```bash
   chmod 400 ./lab-key.pem
   ssh -i ./lab-key.pem ubuntu@PUBLIC_IPV4
   ```

5. Never commit `.pem` files, cloud credentials, tokens, passwords, or private keys.

## Deploy Nginx

On the Ubuntu server:

```bash
sudo apt update
sudo apt install -y nginx
sudo install -d -o root -g root -m 755 /var/www/linux-cloud-lab
sudo install -m 644 web/index.html /var/www/linux-cloud-lab/index.html
```

If the `web/` directory is on your local machine, copy it to the server first (from the local machine):

```bash
scp -i ./lab-key.pem web/index.html ubuntu@PUBLIC_IPV4:/tmp/index.html
```

Then on the server:

```bash
sudo install -m 644 /tmp/index.html /var/www/linux-cloud-lab/index.html
sudo cp config/nginx-linux-cloud-lab /etc/nginx/sites-available/linux-cloud-lab
sudo ln -sfn /etc/nginx/sites-available/linux-cloud-lab /etc/nginx/sites-enabled/linux-cloud-lab
sudo rm -f /etc/nginx/sites-enabled/default
sudo nginx -t
sudo systemctl enable --now nginx
sudo systemctl reload nginx
```

The Nginx site config serves `/var/www/linux-cloud-lab` on port 80. Check `config/nginx-linux-cloud-lab` before applying it. If you prefer not to replace the default site, adapt the config and symlink accordingly.

## Verify

On the server:

```bash
sudo systemctl is-active nginx
sudo ss -lntp | grep ':80'
curl -I http://127.0.0.1/
curl http://127.0.0.1/
```

From your laptop:

```bash
curl -I http://PUBLIC_IPV4/
```

Then open `http://PUBLIC_IPV4/` in a browser. This requires the cloud security group, subnet routing, and host firewall to allow TCP 80.

## Suggested learning sequence

1. `01-linux-basics/`
2. `02-networking/`
3. `03-security/`
4. `04-cloud-deployment/`
5. `05-testing/`

## Evidence to add

Capture your own screenshots and place them in `screenshots/`:

- `01-linux-system-info.png`
- `02-users-groups-permissions.png`
- `03-network-ip-route-dns.png`
- `04-ssh-login.png` (hide usernames/IPs if you prefer)
- `05-ufw-status.png`
- `06-nginx-status.png`
- `07-website-browser.png`

Do not use stock images as evidence. Redact public IPs, account IDs, usernames if sensitive, and all credentials.

## Safety and cost notes

- Cloud resources can incur charges. Stop or terminate lab instances when finished; deleting an instance may also delete attached storage depending on settings.
- Allow SSH before enabling UFW on a remote host. Keep your current SSH session open and test a second session before closing it.
- Do not disable password authentication until key-based login has been tested in a second session.
- Avoid `chmod -R 777`, broad SSH exposure, and destructive commands copied without understanding them.
- This lab is educational, not a production hardening baseline.

## Author

Kashish Sain

## License

MIT. See [LICENSE](LICENSE).
