# Lab 21 - Managing Configuration and Sensitive Data with ConfigMaps and Secrets

## 🎯 Objective

- Create a `Namespace` named **ivolve**  
- Create a `ConfigMap` to store non-sensitive MySQL configuration:
  - `DB_HOST`: the hostname of the MySQL service
  - `DB_USER`: the database user `ivolve-user`
- Create a `Secret` to store sensitive MySQL credentials:
  - `DB_PASSWORD`: `ivolve-password` (encoded)
  - `MYSQL_ROOT_PASSWORD`: `root` (encoded)

---

## 🧾 Step 1 - YAML File

📄 `configmap-secret.yaml`:

```yaml
# ConfigMap - Non-sensitive MySQL configuration
apiVersion: v1
kind: ConfigMap
metadata:
  name: mysql-config
  namespace: ivolve
data:
  DB_HOST: mysql.ivolve.svc.cluster.local
  DB_USER: ivolve-user
---
# Secret - Sensitive MySQL credentials (Base64 encoded)
apiVersion: v1
kind: Secret
metadata:
  name: mysql-secret
  namespace: ivolve
type: Opaque
data:
  DB_PASSWORD: aXZvbHZlLXBhc3N3b3Jk     #ivolve-password
  MYSQL_ROOT_PASSWORD: cm9vdA==         #root
```

---

## 🛠 Step 2 - Apply the File

```bash
kubectl apply -f configmap-secret-lab.yaml
```

📸 <img width="585" height="62" alt="Image" src="https://github.com/user-attachments/assets/1956cba5-2672-4b22-9920-651060398ba8" />


---

## 🔍 Step 3 - Check ConfigMap

```bash
kubectl get configmap -n ivolve
kubectl describe configmap mysql-config -n ivolve
```

📸 <img width="718" height="503" alt="Image" src="https://github.com/user-attachments/assets/87fe7a9f-9781-40ea-be55-eff734fc4b7d" />

---

## 🔍 Step 4 - Check Secret

```bash
kubectl get secret -n ivolve
kubectl describe secret mysql-secret -n ivolve
```

📸 <img width="699" height="306" alt="Image" src="https://github.com/user-attachments/assets/5f8634db-377a-4a7d-ac87-97181839259f" />

---

## 🔐 Base64 Encoding Reference

To encode values manually:

```bash
echo -n "ivolve-password" | base64       # -> aXZvbHZlLXBhc3N3b3Jk
echo -n "root" | base64                  # -> cm9vdA==
```

---

## ✅ Result
 
- ✅ ConfigMap `mysql-config` holds DB_HOST and DB_USER  
- ✅ Secret `mysql-secret` securely stores DB_PASSWORD and MYSQL_ROOT_PASSWORD  
- ✅ All resources scoped under the `ivolve` namespace

---

## 📚 End of Lab
