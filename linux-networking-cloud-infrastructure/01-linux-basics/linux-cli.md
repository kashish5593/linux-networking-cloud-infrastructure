# Linux CLI fundamentals

Run these commands on Ubuntu. Commands that change system state are marked with `sudo`.

## Orientation and files

```bash
pwd
ls -lah
cd /etc
find /var/log -maxdepth 1 -type f
mkdir -p ~/linux-lab/{docs,backup}
touch ~/linux-lab/docs/notes.txt
printf 'Linux lab\n' > ~/linux-lab/docs/notes.txt
cat ~/linux-lab/docs/notes.txt
cp ~/linux-lab/docs/notes.txt ~/linux-lab/backup/
mv ~/linux-lab/backup/notes.txt ~/linux-lab/backup/notes-old.txt
```

`rm` permanently removes files in the normal shell workflow. Inspect paths before using it.

## System and resource information

```bash
cat /etc/os-release
uname -a
hostnamectl
uptime
df -h
lsblk
free -h
```

## Package management

```bash
sudo apt update
apt list --upgradable
sudo apt upgrade -y
sudo apt install -y curl vim
dpkg -l | grep curl
```

## Exercise

Create `~/linux-lab/report.txt` containing the hostname, OS release, disk usage, and memory summary. Do not include secrets or private keys.
