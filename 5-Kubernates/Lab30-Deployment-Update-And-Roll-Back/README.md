
# Lab 30: Deployment Update and Roll Back

This lab demonstrates how to update a Kubernetes deployment by changing the application image and rolling it out, then rolling back to the previous version if necessary.

---

## 🛠️ Steps

### ✅ Step 1: Modify Application Code

Edit the frontend HTML page "frontend/index.html" and change **`Egypt` → `Cairo`**:

---

### ✅ Step 2: Build and Push a New Docker Image

```bash
docker login -u <docker-user>
docker compose up -d  --build
docker tag 64238bc660a9 <docker-user>/k8s-app:v2
docker push <docker-user>/k8s-app:v2
```
🔲 <img width="876" height="496" alt="Image" src="https://github.com/user-attachments/assets/890de905-2d6d-4623-94c2-5c8fc7be3229" />

---

### ✅ Step 3: Update Deployment Manifest

Update the deployment YAML to use the new image version:

```yaml
image: <docker-user>/k8s-app:v2
```


---

### ✅ Step 4: Apply the Deployment Update

```bash
kubectl apply -f deployment.yaml -n ivolve
kubectl rollout status deployment/nodejs-app -n ivolve
```

🔲 <img width="1001" height="142" alt="Image" src="https://github.com/user-attachments/assets/f2f56c0c-453f-4bfd-bbf6-b66610a610a9" />
---

### ✅ Step 5: Verify Application Update

Access the app via browser or `curl` and confirm the word **"Cairo"** is displayed.

```bash
kubectl port-forward svc/nodejs-service 8080:80 -n ivolve --address=0.0.0.0
```

🔲 <img width="1920" height="1031" alt="Image" src="https://github.com/user-attachments/assets/4cd59469-a059-4c70-9ac9-50e43f0929a2" />

---

### ✅ Step 6: Check Rollout History

```bash
kubectl rollout history deployment/nodejs-app -n ivolve
```

🔲 <img width="824" height="166" alt="Image" src="https://github.com/user-attachments/assets/caf22ef9-61f0-4b2c-ad79-59fc252ed80d" />
---

### ✅ Step 7: Rollback to Previous Version

```bash
kubectl rollout undo deployment/nodejs-app -n ivolve
```

Monitor rollback:

```bash
kubectl get pods -n ivolve -w
```

🔲 <img width="793" height="243" alt="Image" src="https://github.com/user-attachments/assets/3a5796e6-1f63-42f2-913d-9e2f7a8f2e1f" />

---

### ✅ Step 8: Verify Rollback

Access the application again and confirm the content reverted to **"Egypt"**.

🔲 <img width="1920" height="1032" alt="Image" src="https://github.com/user-attachments/assets/536901d0-680c-47f7-b476-cf69289b65fb" />

---

## ✅ Summary

| Task                     | Done ✅ |
|--------------------------|--------|
| Code modified            | ☑️     |
| Image built & pushed     | ☑️     |
| Deployment updated       | ☑️     |
| Rollout monitored        | ☑️     |
| App verified (v2)        | ☑️     |
| Rollback performed       | ☑️     |
| App verified (rollback)  | ☑️     |

---
