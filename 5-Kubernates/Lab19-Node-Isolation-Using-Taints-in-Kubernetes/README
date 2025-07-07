# Lab 19: Node Isolation Using Taints in Kubernetes

## 🧪 Objective  
Isolate Kubernetes workloads by **tainting nodes** to restrict pod scheduling unless explicitly tolerated.

---

## ⚙️ Lab Setup

- Kubernetes Cluster with **3 nodes**
  - Tools used: `Minikube (multi-node)`

---

## 🛠️ Steps

### 1. Start a 3-node Kubernetes Cluster
```bash
kubectl get nodes
```

🔍 Output:
<img width="535" height="106" alt="Image" src="https://github.com/user-attachments/assets/efe277cb-c5c4-450a-9b7a-8af2168ead25" />
---

### 2. Apply Taints to Nodes

#### 🔹 Taint Master Node
```bash
kubectl taint nodes master workload=master:NoSchedule
```

#### 🔹 Taint App Node
```bash
kubectl taint nodes node1 workload=app:NoSchedule
```

#### 🔹 Taint Database Node
```bash
kubectl taint nodes node2 workload=database:NoSchedule
```

🖥️ Output:

<img width="743" height="121" alt="Image" src="https://github.com/user-attachments/assets/0205a46f-fcd8-4f94-bb16-d3c0043a48f3" />

---

### 3. Verify Taints Applied
```bash
kubectl describe nodes | grep -i taint
```

🖥️ Output:

<img width="731" height="82" alt="Image" src="https://github.com/user-attachments/assets/3fabe8f9-6f62-440a-ab1e-801002cb284a" />

---

## 📘 Taint Effect Types

| Effect Type        | Description                                           |
|--------------------|-------------------------------------------------------|
| `NoSchedule`       | Blocks pods from being scheduled unless they have a toleration        |
| `PreferNoSchedule` | Tries to avoid placing pods on the node, but not strictly enforced  |
| `NoExecute`        | Immediately removes existing pods and stops new ones from running             |

---
