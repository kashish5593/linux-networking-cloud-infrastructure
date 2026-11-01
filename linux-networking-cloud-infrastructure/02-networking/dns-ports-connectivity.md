# DNS, ports, and connectivity

## DNS tools

```bash
sudo apt install -y dnsutils
getent hosts example.com
nslookup example.com
dig example.com A
dig example.com AAAA
cat /etc/resolv.conf
```

DNS translates names to records such as A (IPv4) and AAAA (IPv6). `/etc/resolv.conf` may be managed by `systemd-resolved` or NetworkManager; avoid editing it blindly.

## Common ports

| Port | Protocol | Service |
|---:|---|---|
| 22 | TCP | SSH |
| 53 | UDP/TCP | DNS |
| 80 | TCP | HTTP |
| 443 | TCP | HTTPS |
| 3306 | TCP | MySQL |
| 5432 | TCP | PostgreSQL |
| 8080 | TCP | Common alternate HTTP |

## Listening sockets and remote tests

```bash
sudo ss -lntup
sudo ss -lntp | grep ':80'
nc -vz SERVER_IP 22
curl -I --connect-timeout 5 http://SERVER_IP/
```

A port test checks TCP reachability, not whether the application returns correct content.
