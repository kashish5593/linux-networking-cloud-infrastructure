# SSH key-based authentication

## Generate a key on your client

```bash
ssh-keygen -t ed25519 -C "linux-cloud-lab"
```

Keep the private key on your client. Never upload it to GitHub. The `.pub` file is the public key.

## Install public key

If available:

```bash
ssh-copy-id -i ~/.ssh/id_ed25519.pub ubuntu@SERVER_IP
```

Or append the public key content to the remote user's `~/.ssh/authorized_keys`, then on the server:

```bash
chmod 700 ~/.ssh
chmod 600 ~/.ssh/authorized_keys
chown -R "$USER":"$(id -gn)" ~/.ssh
```

Connect:

```bash
ssh -i ~/.ssh/id_ed25519 ubuntu@SERVER_IP
```

## Hardening sequence

1. Keep the current SSH session open.
2. Open a second terminal and prove key login works.
3. Confirm the correct user and key permissions.
4. Only then consider disabling password authentication.

Review `/etc/ssh/sshd_config` and any included config files. Validate before reload:

```bash
sudo sshd -t
sudo systemctl reload ssh
```

Do not disable password login if key login has not been verified. Cloud images may manage SSH configuration through cloud-init.
