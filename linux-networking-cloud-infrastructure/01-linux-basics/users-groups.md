# Users and groups

## Create a lab group and user

```bash
sudo groupadd devops-lab
sudo useradd --create-home --shell /bin/bash labuser
sudo passwd labuser
sudo usermod --append --groups devops-lab labuser
id labuser
groups labuser
getent group devops-lab
```

`--append` (`-a`) matters with `usermod -G`; without it, supplementary groups can be replaced.

## Switch user and inspect identity

```bash
su - labuser
whoami
id
exit
```

## Remove lab account (only when finished)

```bash
sudo userdel --remove labuser
sudo groupdel devops-lab
```

Do not remove system accounts or your only administrative account. On cloud images, the default account (often `ubuntu`) is used for administration.
