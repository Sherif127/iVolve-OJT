# 🧪 Lab 5: NGINX Installation and Custom Web Page 

## 🎯 Objective

Use Ansible to automate:
- Installing NGINX
- Starting and enabling the service
- Deploying a custom HTML page with your name and internship info

---

## 🖥️ Environment

- **Control Node**: EC2 (Amazon Linux) with Ansible installed
- **Managed Node**: EC2 (Amazon Linux)
- **SSH**: Already configured
- **Inventory file**: `hosts.ini`

---

## 📁 Folder Structure

ansible-lab/
├── hosts.ini
├── nginx_playbook.yml
└── index.html


---

## ▶️ How to Run

### Navigate to the project folder:

#### Run the playbook:
```bash
ansible-playbook -i hosts.ini nginx_playbook.yml
```
#### 🌐 Test the Result
run:
```bash
Curl http://<MANAGED_NODE_PUBLIC_IP>
```
You should will see:
![Image](https://github.com/user-attachments/assets/d215f9af-a201-42c2-a225-a23279088ee1)

`You can customize it as you want`