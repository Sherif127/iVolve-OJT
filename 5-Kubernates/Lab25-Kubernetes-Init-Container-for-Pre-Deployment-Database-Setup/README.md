# Lab 25: Kubernetes Init Container for Pre-Deployment Database Setup

## 🎯 Objective

- Extend the Node.js deployment with an **init container** to prepare the MySQL database.
- Ensure:
  - `ivolve` database is created.
  - `ivolve-user` is created with full access.
- Use `mysql:5.7` as the init container image.
- Use `kubectl logs` to verify init container ran successfully.
- Use `kubectl exec` + MySQL CLI to verify DB and user exist.
- Forward traffic to Node.js app from browser.

---

## 🏗️ Deployment Changes

### ✅ Init Container Logic

- Waits for MySQL to be available
- Runs SQL to:
  - Create database
  - Create user
  - Grant privileges

### ✅ Used `ConfigMap` and `Secret` for:

- `DB_HOST`
- `DB_USER`
- `DB_PASSWORD`
- `MYSQL_ROOT_PASSWORD`

⚙️ ConfigMap: mysql-config

<img width="434" height="405" alt="Image" src="https://github.com/user-attachments/assets/fc346c69-2c30-4ab3-8046-e0606054ef9d" />

🔐 Secret: mysql-secret

<img width="490" height="241" alt="Image" src="https://github.com/user-attachments/assets/c950c111-1f4b-4759-8d0d-a6da72493905" />


---

## 🧱 Kubernetes Deployment


- [Deployment.yaml](https://github.com/Sherif127/iVolve-OJT/blob/main/5-Kubernates/Lab25-Kubernetes-Init-Container-for-Pre-Deployment-Database-Setup/deployment.yaml)


---

## ✅ Testing Steps

### 🔍 Logs
```bash
kubectl logs <nodejs-pod-name> -c init-mysql-db -n ivolve
```
📋 Application Logs
<img width="677" height="182" alt="Image" src="https://github.com/user-attachments/assets/b5f53921-e203-456d-a0d6-42370deedeb2" />

### 🔍 Manual Verification
```bash
kubectl exec -it mysql-0 -n ivolve -- mysql -uroot -p
```

```sql
SHOW DATABASES;
SELECT user, host FROM mysql.user;
SHOW GRANTS FOR 'ivolve-user'@'%';
```

<img width="895" height="755" alt="Image" src="https://github.com/user-attachments/assets/f754e8d3-fd85-4bd4-828c-96e9705910d0" />

<img width="621" height="174" alt="Image" src="https://github.com/user-attachments/assets/0cdc9b79-2667-4085-9c02-e065edc411e8" />
---

## 🌍 Accessing Node.js App via Browser

```bash
kubectl port-forward svc/nodejs-service 8080:80 -n ivolve --address=0.0.0.0
```

✅ Open: `http://<EC2_PUBLIC_IP>:8080`

_(Used 0.0.0.0 because this is a cloud environment on AWS)_

📸:
<img width="967" height="101" alt="Image" src="https://github.com/user-attachments/assets/c30f18ee-9f95-46e0-acaf-49c61cdef3b5" />

---

## 📸 Screenshot: Web UI

<img width="1920" height="1030" alt="Image" src="https://github.com/user-attachments/assets/246354df-6d10-4a20-a0bf-381fb2604c34" />

📸 Check health:

<img width="1920" height="1024" alt="Image" src="https://github.com/user-attachments/assets/869bc056-2e4d-49c9-9e35-8ff892583d61" />

📸 Check if ready:

<img width="1920" height="1026" alt="Image" src="https://github.com/user-attachments/assets/4be2274f-e42e-4558-8f6f-bbf28ef6eab8" />

---

## 📸 Screenshot: Init Container Logs

<img width="900" height="82" alt="Image" src="https://github.com/user-attachments/assets/20fc87f4-6888-4150-a891-a9b6f8862243" />