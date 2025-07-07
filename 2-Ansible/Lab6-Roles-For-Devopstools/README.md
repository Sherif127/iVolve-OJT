# 🧪 Lab 6: Setup Docker, kubectl, and Jenkins Using Ansible Roles

## 🎯 Objective

Use Ansible **roles** to automate the setup of essential DevOps tools on a managed Amazon Linux EC2 instance:

- Install and configure **Docker**
- Install **kubectl** (Kubernetes CLI) from official source
- Install **Jenkins**, start the service, and display the initial admin password

---

## 🖥️ Environment

- **Control Node**: EC2 (Amazon Linux) with Ansible installed
- **Managed Node**: EC2 (Amazon Linux)
- **SSH**: Key-based authentication is already configured
- **Inventory File**: `hosts`

---

## 📁 Folder Structure

```
ansible-lab/
├── hosts.ini
├── playbook.yml
├── README.md
└── roles/
    ├── docker/
    │   └── tasks/main.yml
    ├── kubectl/
    │   └── tasks/main.yml
    └── jenkins/
        └── tasks/main.yml
```

---

## ▶️  Run the playbook:

```bash
ansible-playbook -i hosts.ini playbook.yml
```

---

## 📦 Roles Overview

### 🔧 Docker Role

- Installs Docker from the default package manager
- Starts the Docker service and enables it on boot
- Adds `ec2-user` to the `docker` group

### ☸️ kubectl Role

- Fetches the latest stable version of `kubectl`
- Downloads it from the official Kubernetes website
- Makes it executable and verifies the installation

### ⚙️ Jenkins Role

- Installs Java (Amazon Corretto 17)
- Adds Jenkins official repo and key
- Installs Jenkins
- Starts and enables the Jenkins service
- Waits for Jenkins to initialize
- Displays the **initial admin password** clearly using `cat`

---

## 🔐 Example Output

![Image](https://github.com/user-attachments/assets/d349aced-a6aa-4265-b9fb-48ae3e4ebf43)

---

## 🌐 Access Jenkins

1. Open in your browser:

```
http://<MANAGED_NODE_PUBLIC_IP>:8080
```
![Image](https://github.com/user-attachments/assets/5fc7437a-18f8-4e38-b519-0e77b6efff7e)

2. Login using the admin password shown in the output.

---

## 📌 Notes

- Ensure **port 8080** is allowed in your Security Group to access Jenkins.
- Docker can now be used directly with `ec2-user`.
- `kubectl` is globally available via `/usr/local/bin/kubectl`.

---

👨‍💻 Created by **Sherif Shaban** – *iVolve Internship*
