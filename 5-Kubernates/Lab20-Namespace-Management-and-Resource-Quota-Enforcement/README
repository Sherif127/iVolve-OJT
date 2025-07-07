# Lab 21 - Namespace and ResourceQuota

## 🎯 Objective

Create a namespace called `ivolve` and apply a ResourceQuota to limit the number of pods to **2**.

---

## 📄 Step 1 - YAML Definition (`namespace-quota.yaml`)

```yaml
apiVersion: v1
kind: Namespace
metadata:
  name: ivolve
---
apiVersion: v1
kind: ResourceQuota
metadata:
  name: pods-limits
  namespace: ivolve
spec:
  hard:
    pods: "2"
```

---

## 🛠️ Step 2 - Apply the Configuration

```bash
kubectl apply -f namespace-quota.yaml
```

📸 <img width="536" height="66" alt="Image" src="https://github.com/user-attachments/assets/9ac1241c-453d-4d50-9962-782e52bd070b" />

---

## 🔍 Step 3 - Verify Namespace Created

```bash
kubectl get namespaces
```

📸 <img width="370" height="167" alt="Image" src="https://github.com/user-attachments/assets/f0315e0a-375c-475a-bfc9-a49385b646da" />
---

## 📏 Step 4 - Verify ResourceQuota

```bash
 kubectl get resourcequota -n ivolve
```

```
NAME          REQUEST     LIMIT   AGE
pods-limits   pods: 0/2           28s
```

---

## 🔍 Step 5 - Describe the Quota

```bash
kubectl describe resourcequota pods-limits -n ivolve
```
📸 <img width="740" height="125" alt="Image" src="https://github.com/user-attachments/assets/cb093e1a-a1de-44ee-a65c-6277473a7ec9" />

---

## ✅ Result

- The namespace `ivolve` has a quota named `pods-limits`
- It allows only **2 pods maximum**
- If you try to create a 3rd pod, it will be **denied**

---

## 🔚 End of Lab
