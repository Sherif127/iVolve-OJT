
# 🧪 Lab 4: Ansible Installation on AWS EC2

  

## 🎯 Objective

Install and configure Ansible Automation Platform on a control node and prepare a managed node for automation via SSH and Ansible inventory.

  

## 🖥️ Environment

- Control Node: EC2 instance (Amazon Linux)

- Managed Node: EC2 instance (Amazon Linux)

- Both in the same VPC/security group to allow SSH (port 22)

  

## 🛠️ Steps

  

### 1. Install Ansible on Control Node

Run the following commands:

```bash
sudo  dnf  install  -y  ansible
```

  

### 2. Create Ansible Inventory File

Run:

```bash
mkdir  ~/ansible-lab
cd  ~/ansible-lab
```

Create the hosts file with:

```bash
vim  hosts
```

Then Add the content:

```bash
[web]
managed-node ansible_host=<MANAGED_NODE_PRIVATE_IP> ansible_user=ec2-user
```
`Replace <MANAGED_NODE_PRIVATE_IP> with the private IP of the managed node.`

  

### 3. Generate SSH Key on Control Node

Run:
```bash
ssh-keygen
```

  

### 4. Copy SSH Key to Managed Node

Run:

```bash
ssh-copy-id  -i  ~/.ssh/id_rsa.pub  ec2-user@<MANAGED_NODE_PRIVATE_IP>
```

If ssh-copy-id is not available, use:

```bash
cat  ~/.ssh/id_rsa.pub | ssh  ec2-user@<MANAGED_NODE_PRIVATE_IP> 'mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys'
```

### 5. Test Ad-Hoc Ansible Command

Run:
```bash
ansible  -i  hosts  web  -m  command  -a  "df -h"
```

# Verification

### SSH-Keygen

![Image](https://github.com/user-attachments/assets/5e573e37-d76a-4fcf-9d87-cdbe3039fff1)

  

### SSH-Copy-ID

![Image](https://github.com/user-attachments/assets/6c84fb7c-31fb-4fe9-aad3-972029ad5af3)

  

### Ad-Hoc Command

![Image](https://github.com/user-attachments/assets/a0846c36-4bb0-4cba-9009-ea34f6087ae9)