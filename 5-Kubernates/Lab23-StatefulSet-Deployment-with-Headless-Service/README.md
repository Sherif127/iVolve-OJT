# Lab 23: StatefulSet Deployment with Headless Service (MySQL on Kubernetes)

## 🧪 Lab Goal

Deploy a **MySQL StatefulSet** using a **Headless Service** in a dedicated namespace (`ivolve`). This setup includes:

- Persistent storage using a **StorageClass** backed by **AWS EBS**
- Secrets to store MySQL credentials
- Data persistence after pod deletion
- Creating and verifying a table in a MySQL database

---

## 📁 Repository Structure

```bash
.
├── secret.yaml
├── storage-class.yaml
├── pvc.yaml
├── statefulset.yaml
├── svc.yaml
└── README.md
```

---

## 📝 Lab Steps

### ✅ 1. Create Namespace

All resources are deployed in the `ivolve` namespace.

### 🔐 2. Create Secret

Secret `mysql-secret` stores base64-encoded values for:

- `MYSQL_ROOT_PASSWORD`: `root`
- `DB_PASSWORD`: `ivolve-password`

### 💽 3. StorageClass

Custom `StorageClass` named `ebs-static-sc` configured for AWS EBS with:

- `provisioner: ebs.csi.aws.com`
- `volumeBindingMode: WaitForFirstConsumer`
- `reclaimPolicy: Retain`

### 📦 4. StatefulSet with PVC

- Uses `mysql:5.7` image.
- Mounts volume at `/var/lib/mysql`.
- Secret is mounted as environment variable for root password.
- Includes toleration for `workload-database:NoSchedule`.


### 🌐 5. Headless Service

A headless service named `mysql` with:

- `clusterIP: None`
- Port `3306` exposed
- Targets pods with label `app: mysql`
---
## ⚙️ Apply Resources

```bash
kubectl apply -f secret.yaml
kubectl apply -f storage-class.yaml
kubectl apply -f pvc.yaml
kubectl apply -f svc.yaml
kubectl apply -f statefulset.yaml
```

---

## ✅ Verify Everything

```bash
kubectl get pods -n ivolve
kubectl get svc -n ivolve
kubectl get pvc -n ivolve
kubectl get pv
```
<img width="1148" height="366" alt="Image" src="https://github.com/user-attachments/assets/019f855e-326f-4ef1-bfdc-1ddac0d3d85e" />

---
## 🔄 EBS Volume 
> The Volume is attached automatically

<img width="1664" height="348" alt="Image" src="https://github.com/user-attachments/assets/fdd26426-734c-41ce-a9d5-2f6519426cf4" />
---

## 🧪 Test Data Persistence

1. Connect to MySQL:

```bash
kubectl exec -n ivolve -it mysql-0 -- mysql -uroot -p
```

2. Inside MySQL prompt, run:

```sql
CREATE DATABASE ivolve;
USE ivolve;
CREATE TABLE student (id INT AUTO_INCREMENT PRIMARY KEY, name VARCHAR(100));
INSERT INTO student (name) VALUES ('Sherif Shaban');
SELECT * FROM student;
```

✅ Expected Output:

```text
+----+---------------+
| id |    name       |
+----+---------------+
|  1 | Sherif Shaban |
+----+---------------+
```

3. Delete and watch the pod:

```bash
kubectl delete pod -n ivolve mysql-0
kubectl get pods -n ivolve -w
```

4. Reconnect after pod is Running:

```bash
kubectl exec -n ivolve -it mysql-0 -- mysql -uroot -p
USE ivolve;
SELECT * FROM student;
```

<img width="987" height="656" alt="Image" src="https://github.com/user-attachments/assets/4f3c42e0-fed2-4e20-8803-5cd4f30a39e3" />

✅ The table and data should still be there.

---
