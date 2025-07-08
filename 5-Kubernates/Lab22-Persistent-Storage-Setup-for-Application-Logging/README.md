# Lab 22: Persistent Storage Setup for Application Logging (kubeadm)

## 🎯 Objective

Set up a Persistent Volume (PV) and Persistent Volume Claim (PVC) using `hostPath` for storing application logs permanently on a specific node in a kubeadm Kubernetes cluster.

---

## 🧱 Step 1: Prepare the Directory on the Target Node

1. List your nodes to identify the worker node:
   ```bash
   kubectl get nodes
   ```
  <img width="510" height="103" alt="Image" src="https://github.com/user-attachments/assets/fba995d3-5946-42d3-acfc-72ea11fef9db" />

2. SSH into the node:
   ```bash
   ssh node1
   ```

3. Create the target directory with full permissions:
   ```bash
   sudo mkdir -p /mnt/app-logs
   sudo chmod 777 /mnt/app-logs
   ```

---

## 📁 Step 2: Create Persistent Volume (PV)

**File: `pv.yaml`**
```yaml
apiVersion: v1
kind: PersistentVolume
metadata:
  name: app-logs-pv
spec:
  capacity:
    storage: 1Gi
  accessModes:
    - ReadWriteMany
  persistentVolumeReclaimPolicy: Retain
  hostPath:
    path: /mnt/app-logs
  nodeAffinity:
    required:
      nodeSelectorTerms:
        - matchExpressions:
            - key: kubernetes.io/hostname
              operator: In
              values:
                - node1  
```

Apply the PV:
```bash
kubectl apply -f pv.yaml
```
<img width="699" height="66" alt="Image" src="https://github.com/user-attachments/assets/d2e42401-ba0d-41c8-8195-34b14cbea4b7" />

---

## 📦 Step 3: Create Persistent Volume Claim (PVC)

**File: `pvc.yaml`**
```yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: app-logs-pvc
spec:
  accessModes:
    - ReadWriteMany
  resources:
    requests:
      storage: 1Gi
```

Apply the PVC:
```bash
kubectl apply -f pvc.yaml
```

<img width="716" height="64" alt="Image" src="https://github.com/user-attachments/assets/574c7e51-d671-4dfd-8178-6c8842fe9837" />

---

## ✅ Verification Commands

```bash
kubectl get pv
kubectl get pvc
```
<img width="1410" height="124" alt="Image" src="https://github.com/user-attachments/assets/c0908e52-87d9-49f4-8841-bac2ec1414b6" />

---

## ✅ Summary

| Step | Status |
|------|--------|
| `/mnt/app-logs` created on correct node | ✅ |
| PV created and attached to node with nodeAffinity | ✅ |
| PVC created with matching ReadWriteMany access | ✅ |
