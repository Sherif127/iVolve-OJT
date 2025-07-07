# Ansible Playbook: Apache Web Server Deployment on EC2 using Dynamic Inventory

This lab contains an Ansible playbook that provisions Apache (httpd) web servers on AWS EC2 instances dynamically discovered via their tags using the `amazon.aws.aws_ec2` dynamic inventory plugin to show a simple styled web page.

---

## 🎯 Objective

- Automate Apache installation and configuration on EC2.
- Use AWS dynamic inventory via `amazon.aws.aws_ec2` plugin.
- Tag-based EC2 instance selection (`Name=ivolve`).
- Ensure Apache is running and enabled at boot.
- Practice secure key-based SSH with Ansible.
- Demonstrate dynamic provisioning with public IP mapping.

---

## 📁 Lab Structure

```
Lab8-Dynamic-Inventory/
├── apache_playbook.yml       
├── index.html                  
├── aws_ec2.yml                 
└── ansible.cfg 
```

---

## ⚙️ Dependencies

- Python packages:
  - `boto3`, `botocore`, `awscli`
- Ansible Collections:
  - `amazon.aws`
- AWS IAM credentials configured via `aws configure`
- SSH keypair with correct permissions
- EC2 instance(s) tagged with `Name=ivolve`

---

## 🚀 Run the Playbook

![Image](https://github.com/user-attachments/assets/6c705025-ce83-4b09-8673-d7444d35cd6f)

---

## ✅ Result
[My Web Page]

![Image](https://github.com/user-attachments/assets/eca971b7-4213-49e1-b6c3-2ee9d290b2ba)

---
