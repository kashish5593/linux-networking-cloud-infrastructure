# AWS EC2 security group

Use least privilege. Example inbound rules for a public HTTP lab:

| Type | Protocol | Port | Source |
|---|---|---:|---|
| SSH | TCP | 22 | Your public IPv4 `/32` |
| HTTP | TCP | 80 | `0.0.0.0/0` (only if public website intended) |
| HTTPS | TCP | 443 | `0.0.0.0/0` (only after TLS is configured) |

Notes:
- Do not expose SSH to `0.0.0.0/0` for routine use.
- Security groups are stateful; response traffic is automatically allowed.
- Check subnet route table, internet gateway, public IPv4 assignment, network ACLs, and instance firewall if access fails.
- A private subnet instance needs a suitable private access path (for example, VPN, bastion, or Systems Manager) rather than an exposed public SSH endpoint.
- Review current AWS pricing and stop/terminate resources after the lab.
