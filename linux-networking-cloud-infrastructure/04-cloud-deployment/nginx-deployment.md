# Install and deploy Nginx

## Install

```bash
sudo apt update
sudo apt install -y nginx
sudo systemctl enable --now nginx
sudo systemctl is-active nginx
```

## Deploy content

Copy `web/index.html` to the server, then:

```bash
sudo install -d -o root -g root -m 755 /var/www/linux-cloud-lab
sudo install -o root -g root -m 644 /tmp/index.html /var/www/linux-cloud-lab/index.html
```

Install the supplied site config:

```bash
sudo cp config/nginx-linux-cloud-lab /etc/nginx/sites-available/linux-cloud-lab
sudo ln -sfn /etc/nginx/sites-available/linux-cloud-lab /etc/nginx/sites-enabled/linux-cloud-lab
sudo nginx -t
sudo systemctl reload nginx
```

If Nginx reports a duplicate `default_server`, inspect enabled sites and disable the conflicting default site only if appropriate.

## Verify

```bash
curl -I http://127.0.0.1/
curl http://127.0.0.1/
sudo ss -lntp | grep ':80'
sudo journalctl -u nginx -n 50 --no-pager
```

From a client, test `curl -I http://PUBLIC_IPV4/` and open the address in a browser. Ensure both UFW and cloud security group allow TCP 80.
