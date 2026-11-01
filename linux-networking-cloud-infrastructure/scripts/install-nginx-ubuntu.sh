
#!/usr/bin/env bash

# Install Nginx and deploy the static website
# Run this script from the project root on Ubuntu EC2.

set -euo pipefail

echo "Checking project files..."

if [[ ! -f web/index.html || ! -f config/nginx-linux-cloud-lab ]]; then
    echo "ERROR: Run this script from the repository root."
    echo "Required: web/index.html and config/nginx-linux-cloud-lab"
    exit 1
fi

echo "Updating package lists..."
sudo apt-get update

echo "Installing Nginx..."
sudo apt-get install -y nginx

echo "Creating website directory..."
sudo install -d -o root -g root -m 755 /var/www/linux-cloud-lab

echo "Copying website files..."
sudo install -o root -g root -m 644 web/index.html /var/www/linux-cloud-lab/index.html

echo "Installing Nginx configuration..."
sudo install -o root -g root -m 644 config/nginx-linux-cloud-lab /etc/nginx/sites-available/linux-cloud-lab

echo "Enabling website..."
sudo ln -sfn /etc/nginx/sites-available/linux-cloud-lab /etc/nginx/sites-enabled/linux-cloud-lab

if [[ -L /etc/nginx/sites-enabled/default ]]; then
    sudo rm /etc/nginx/sites-enabled/default
fi

echo "Testing Nginx configuration..."
sudo nginx -t

echo "Starting Nginx..."
sudo systemctl enable --now nginx
sudo systemctl reload nginx

echo "Testing website..."
curl -I http://127.0.0.1/

echo "Deployment completed successfully!"
