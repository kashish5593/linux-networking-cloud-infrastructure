# Processes and systemd services

## Processes

```bash
ps aux
top
pgrep -a nginx
```

Stop only a process you own or are authorized to manage:

```bash
kill PID
```

Use `kill -9 PID` only as a last resort; it prevents graceful cleanup.

## Services

```bash
systemctl status ssh
sudo systemctl enable --now ssh
sudo systemctl restart ssh
sudo systemctl is-enabled ssh
sudo systemctl is-active ssh
journalctl -u ssh --since '30 minutes ago'
```

For Nginx:

```bash
sudo systemctl status nginx
sudo journalctl -u nginx -n 50 --no-pager
```
