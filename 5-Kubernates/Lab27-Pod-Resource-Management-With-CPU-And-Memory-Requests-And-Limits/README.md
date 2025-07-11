# Lab 27: Pod Resource Management with CPU and Memory Requests and Limits

## 🎯 Lab Objective

Configure and manage Kubernetes pod resource allocation for CPU and memory using:

- ✅ **Resource Requests** to guarantee minimum resources for scheduling.
- ✅ **Resource Limits** to cap the maximum usage of CPU and memory.

---

## 📦 Deployment Configuration

Node.js app updated to include resource requests and limits:

```yaml
resources:
  requests:
    memory: "1Gi"
    cpu: "1"
  limits:
    memory: "2Gi"
    cpu: "2"
```

---

## 🛠️ Steps to Apply Deployment


### Apply the deployment

```bash
kubectl apply -f deployment.yaml
```

- [Deployment.yaml](https://github.com/Sherif127/iVolve-OJT/blob/main/5-Kubernates/Lab27-Pod-Resource-Management-With-CPU-And-Memory-Requests-And-Limits/deployment.yaml)

---

### Get pod status

```bash
kubectl get pods -n ivolve
```

---

### Verify resource requests and limits

```bash
kubectl describe pod <pod-name> -n ivolve
```

Look for:
- Limits: `cpu: 2`, `memory: 2Gi`
- Requests: `cpu: 1`, `memory: 1Gi`

#### 📸 Screenshot:

<img width="1226" height="384" alt="Image" src="https://github.com/user-attachments/assets/26ec37b7-b79c-4331-b8e1-cc17ff78210d" />

---

### Check real-time resource usage

```bash
kubectl top pods -n ivolve
```

Expected output:
```bash
NAME                          CPU(cores)   MEMORY(bytes)
nodejs-app-xxx                1m           21Mi
```

#### 📸 Screenshot:

<img width="616" height="106" alt="Image" src="https://github.com/user-attachments/assets/d9411d9a-f5c8-4c7d-a3b1-4d8ef584f468" />

---
## 📝 Notes

- Requests help the scheduler assign pods properly.
- Limits ensure fair usage and prevent resource hogging.
- Use Metrics Server to enable `kubectl top`.
