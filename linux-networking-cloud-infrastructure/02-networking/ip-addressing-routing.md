# IP addressing and routing

## Inspect interfaces and routes

```bash
ip -br address
ip link
ip route
ip neigh
```

- IPv4 address identifies an interface.
- CIDR prefix describes network size; e.g. `/24` corresponds to 255.255.255.0.
- Default route (`default via ...`) points to the next-hop gateway.

## CIDR examples

| CIDR | Subnet mask | Addresses | Typical usable IPv4 hosts |
|---|---|---:|---:|
| `192.168.10.0/24` | `255.255.255.0` | 256 | 254 |
| `10.0.0.0/16` | `255.255.0.0` | 65,536 | 65,534 |
| `172.16.1.0/24` | `255.255.255.0` | 256 | 254 |

Cloud networks reserve some addresses, so usable counts may differ from basic subnet arithmetic.

## Connectivity

```bash
ping -c 4 1.1.1.1
tracepath 1.1.1.1
ip route get 1.1.1.1
```

ICMP ping may be blocked even when TCP services work. Use service-specific tests too.
