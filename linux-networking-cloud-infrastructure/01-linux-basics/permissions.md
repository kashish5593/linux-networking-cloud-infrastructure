# Linux ownership and permissions

Linux permissions apply to owner, group, and others. Numeric values: read=4, write=2, execute=1.

```bash
mkdir -p ~/linux-lab/permissions
touch ~/linux-lab/permissions/app.conf
ls -l ~/linux-lab/permissions/app.conf
chmod 640 ~/linux-lab/permissions/app.conf
chmod 750 ~/linux-lab/permissions
sudo chown "$USER":"$(id -gn)" ~/linux-lab/permissions/app.conf
stat ~/linux-lab/permissions/app.conf
```

- `640`: owner read/write, group read, others no access.
- `750`: owner full, group read/execute, others no access.
- `chown user:group path`: changes owner and group.

Avoid `chmod -R 777`. Use the narrowest permissions needed. For web content, files are commonly `644` and directories `755`, owned by root or a deployment account with carefully scoped write access.
