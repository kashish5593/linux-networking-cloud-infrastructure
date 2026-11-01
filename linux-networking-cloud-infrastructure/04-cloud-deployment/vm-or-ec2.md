# Provision an Ubuntu VM or EC2 instance

## Local VirtualBox option

1. Download the Ubuntu Server ISO from the official Ubuntu website.
2. Create a VM with roughly 2 vCPU, 2 GB RAM, and 20 GB disk for this small lab.
3. Install Ubuntu Server and create a non-root user.
4. Install/enable OpenSSH Server during setup or run:

   ```bash
   sudo apt update
   sudo apt install -y openssh-server
   sudo systemctl enable --now ssh
   ```

5. Run `ip -br addr` to identify the guest address.
6. Configure VirtualBox networking for host access (bridged adapter or NAT port forwarding).

## AWS EC2 option

1. Open EC2 and launch an Ubuntu Server AMI.
2. Choose an instance type suitable for a small lab and check current Free Tier/plan eligibility and regional pricing.
3. Create/select a key pair and store the private key securely.
4. Attach a security group with SSH restricted to your IP and HTTP only if needed.
5. Ensure the subnet route table has an internet gateway route for direct public access.
6. Connect:

   ```bash
   chmod 400 lab-key.pem
   ssh -i lab-key.pem ubuntu@PUBLIC_IPV4
   ```

7. Update the instance:

   ```bash
   sudo apt update
   sudo apt upgrade -y
   ```

Do not commit the key. Terminate the instance when finished if you no longer need it; check whether EBS volumes and Elastic IPs remain billable.
