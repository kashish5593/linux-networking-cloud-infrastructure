# Verification checklist

Record actual results and dates. Do not mark an item complete based only on configuration.

- [ ] VM/EC2 instance created and reachable.
- [ ] `cat /etc/os-release` confirms Ubuntu.
- [ ] `ip -br addr` shows expected interface/address.
- [ ] `ip route` shows expected default route.
- [ ] `getent hosts example.com` resolves DNS.
- [ ] `id labuser` confirms lab user/group membership (if created).
- [ ] `stat` confirms expected file ownership and permissions.
- [ ] SSH key login succeeds in a second session.
- [ ] Firewall status shows only intended inbound rules.
- [ ] `systemctl is-active nginx` returns `active`.
- [ ] `ss -lntp` shows Nginx listening on TCP 80.
- [ ] `curl -I http://127.0.0.1/` returns HTTP success.
- [ ] Remote `curl` or browser reaches the website.
- [ ] Screenshots are saved with secrets and sensitive identifiers redacted.
- [ ] Cloud resources no longer needed are stopped/terminated and checked for residual charges.

## Evidence log

| Date | Test | Command / method | Actual result | Evidence file |
|---|---|---|---|---|
| YYYY-MM-DD | Nginx service | `systemctl is-active nginx` | Fill in | `screenshots/...` |
| YYYY-MM-DD | Local HTTP | `curl -I http://127.0.0.1/` | Fill in | `screenshots/...` |
