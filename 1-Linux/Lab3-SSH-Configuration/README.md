
# 🧪 Lab 3 : SSH Configuration

This lab demonstrates how to:
- Generate your own SSH key
- Use AWS `.pem` to access an instance
- Replace it with your custom SSH key
- Configure a shortcut using SSH config

---

## ✅ Objectives

- Generate SSH key pair  
- Access EC2 using `.pem`  
- Copy your key to the remote machine  
- Login without `.pem`  
- Use `ssh ivolve` instead of full IP  

---

## ⚙️ Steps

### 1. Generate SSH Key

Run on the source machine (**myserver**):

    ssh-keygen

- Save in: `~/.ssh/id_rsa`
- Leave passphrase empty (or add one if needed)

This generates:
- `~/.ssh/id_rsa` (private)
- `~/.ssh/id_rsa.pub` (public)

---

### 2. Access EC2 (`ivolve`) Using AWS Key

Fix permissions:

    chmod 600 ivolve-key.pem

Login:

    ssh -i ./ivolve-key.pem ec2-user@3.222.116.235

Replace IP with the real public IP of your `ivolve` instance.

---

### 3. Copy Your Public Key to `ivolve`

On `ivolve`:

    mkdir -p ~/.ssh
    vi ~/.ssh/authorized_keys

Paste your public key (`~/.ssh/id_rsa.pub` from **myserver**).

Set permissions:

    chmod 700 ~/.ssh
    chmod 600 ~/.ssh/authorized_keys

Exit the instance:

    exit

---

### 4. Test Passwordless Login

Back on **myserver**:

    ssh ec2-user@3.222.116.235

You should get in with no `.pem` required.

---

### 5. Add SSH Alias 🔥

Edit config on **myserver**:

    vi ~/.ssh/config

Add this block:

![Image](https://github.com/user-attachments/assets/7c8b996b-1a7a-4585-b139-b1c4b659d578)

Now you can just run:

    ssh ivolve

---

## 🔐 Permissions Recap

If issues happen, re-check:

    chmod 600 ~/.ssh/id_rsa
    chmod 700 ~/.ssh
    chmod 600 ~/.ssh/authorized_keys

---

## ✅ Outcome

![Image](https://github.com/user-attachments/assets/187b1839-cc53-4d25-a0da-e75bda2dddd4)

Now you're able to:
- Generate and use your own key
- SSH without `.pem`
- Use `ssh ivolve` like a boss

Perfect for automation tools like Ansible, and cleaner DevOps workflows.

---

*Powered by sweat, coffee, and `chmod 600` errors ☕*
