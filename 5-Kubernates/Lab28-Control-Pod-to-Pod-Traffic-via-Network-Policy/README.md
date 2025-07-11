# Lab 28: Control Pod-to-Pod Traffic via Network Policy

## 🎯 Objective

In this lab, we will **control pod-to-pod communication** in the `ivolve` namespace by applying a `NetworkPolicy` that:
- Allows **only** Node.js application pods (labeled `app=nodejs`) to connect to **MySQL pods** (labeled `app=mysql`).
- Restricts access to **TCP port 3306** (MySQL default port).
- Denies access from all other pods.

---

## 📄 NetworkPolicy Manifest

File: - [Networkpolicy.yaml](https://github.com/Sherif127/iVolve-OJT/blob/main/5-Kubernates/Lab28-Control-Pod-to-Pod-Traffic-via-Network-Policy/networkpolicy.yaml)

```yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: allow-app-to-mysql
  namespace: ivolve
spec:
  podSelector:
    matchLabels:
      app: mysql
  policyTypes:
  - Ingress
  ingress:
  - from:
    - podSelector:
        matchLabels:
          app: nodejs
    ports:
    - protocol: TCP
      port: 3306
```

---

## 🛠️ Steps to Apply

```bash
kubectl apply -f networkpolicy.yaml
```

<img width="696" height="42" alt="Image" src="https://github.com/user-attachments/assets/bba59047-67f8-464d-8c49-880219e4cd36" />

---

## 🔍 Verify the Policy

1. **Describe the applied policy:**
   ```bash
   kubectl describe networkpolicy allow-app-to-mysql -n ivolve
   ```
### 📸 Screenshot :

<img width="998" height="282" alt="Image" src="https://github.com/user-attachments/assets/bd484c2e-9fc8-43d0-a24f-2903be6182a2" />

2. **Test access from nodejs pod (should succeed):**
   - Use a `kubectl exec` from a `nodejs` pod to connect to MySQL via port `3306`.

3. **Test access from unauthorized pod (should fail):**
   - Deploy a `busybox` pod without `app=nodejs` label and try to connect.

---

## ✅ Note
- Ensure your **CNI plugin (like Calico)** supports `NetworkPolicy`, otherwise this won't be enforced.

---