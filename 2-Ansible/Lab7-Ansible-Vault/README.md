# Ansible Playbook: MySQL Setup with Vault Encryption

This repository contains an Ansible playbook that automates the **installation and configuration of MySQL** on a remote Ubuntu-based server.  
The lab also demonstrates how to **secure sensitive credentials** (like database username and password) using **Ansible Vault**, which is the main objective.

---

## 🎯 Lab Objective

- Use **Ansible Vault** to securely store and retrieve sensitive data.
- Automate MySQL installation and configuration on a remote host.
- Set up a MySQL database and user with specific privileges.
- Enable remote access to the MySQL server.
- Practice modular and secure infrastructure automation using best practices.

---

## ⚙️ Lab Dependencies

Make sure the following are installed on your **control node**:

- Python 3
- `ansible`
- `community.mysql` collection  
  Install it using:
  ```bash
  ansible-galaxy collection install community.mysql
  ```
- `mysql-client` (used to connect and verify from control node)

---

## 🧱 Project Structure

```
Lab7-Ansible-Vault/
├── ansible.cfg          
├── inventory.ini       
├── playbook.yml          
├── secret.yml                      
└── .vault_pass          
```

---

## 🔐 About Ansible Vault

`secret.yml` is encrypted using **Ansible Vault**, which allows you to store sensitive data like passwords in source control without exposing them in plain text.

create and encrypt the secret file:
```bash
ansible-vault create secret.yml
```
![Image](https://github.com/user-attachments/assets/b9a27e9f-55a6-4be7-9b78-5c2452f6d566)

You don’t have to enter the password manually every time because of `.vault_pass`:
```ini
# .vault_pass contains only the password used to encrypt secret.yml
1234
```

And this is linked in `ansible.cfg`:
```ini
[defaults]
vault_password_file = .vault_pass
```

---

## 📜 Inventory Example

`inventory.ini` defines the target remote Ubuntu server and the SSH settings:
```ini
[web]
managed-server ansible_host=44.215.123.70 ansible_ssh_private_key_file= ~/.ssh/keypair.pem
```

---

## 🛠️ What the Playbook Does

The playbook performs the following tasks:

1. Updates the APT cache.
2. Installs MySQL server and required dependencies (`python3-pymysql`, `pip3`) to enable Ansible to communicate with MySQL.
3. Ensures the MySQL service is started and enabled.
4. Sets the **root password** for MySQL using `community.mysql.mysql_user`.
5. Creates the `ivolve` database.
6. Creates a MySQL user (e.g., `sherif`) with all privileges on `ivolve.*`.
7. Configures MySQL to allow remote connections by editing `bind-address`.
8. Restarts MySQL to apply changes.

All sensitive variables like `{{ db_user }}` and `{{ db_pass }}` are pulled from `secret.yml`, which is encrypted.

---

## ▶️ Running the Playbook

Run the playbook directly:
```bash
ansible-playbook playbook.yml
```
Ansible will:
- Automatically load the vault password from `.vault_pass`
- Use the encrypted `secret.yml` without manual prompts
- Connect to the target host via SSH and perform all tasks

---

## ✅ Verification

![Image](https://github.com/user-attachments/assets/e26b47cc-244c-43cb-9e1b-327c8a74f0a5)
---
