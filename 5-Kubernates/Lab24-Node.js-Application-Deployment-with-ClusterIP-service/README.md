# Lab 24: Node.js Application Deployment with ClusterIP Service

## 🎯 Objective

- Deploy a custom Node.js application using a Deployment.
- Use 2 replicas to ensure high availability.
- Set environment variables using ConfigMap and Secret:
  - `DB_HOST`
  - `DB_USER`
  - `DB_PASSWORD`
- Add a toleration with key `workload=app` and effect `NoSchedule`.
- Use a pre-created PersistentVolumeClaim for app logs.
- Expose the application using a **ClusterIP** Service.
- Use `kubectl port-forward` to test the app.

---

## 🏗️ Applied Kubernetes Resources

⚙️ ConfigMap: mysql-config

<img width="434" height="405" alt="Image" src="https://github.com/user-attachments/assets/fc346c69-2c30-4ab3-8046-e0606054ef9d" />

🔐 Secret: mysql-secret

<img width="490" height="241" alt="Image" src="https://github.com/user-attachments/assets/c950c111-1f4b-4759-8d0d-a6da72493905" />



### ✅ Deployment

- [Deployment.yaml](https://github.com/Sherif127/iVolve-OJT/blob/8d523068f8a2c607b6aefebf36650a877011686f/5-Kubernates/Lab24-Node.js-Application-Deployment-with-ClusterIP-service/deplyoment.yaml)

Apply it:

```bash
kubectl apply -f deployment.yaml
```
📦 Pods Status

<img width="742" height="105" alt="Image" src="https://github.com/user-attachments/assets/a0d5a4e3-6e30-493a-9681-6b8e4864d1ae" />

📄 Describe Deployment

<img width="943" height="230" alt="Image" src="https://github.com/user-attachments/assets/7e9d313a-4f97-4128-85f1-65b6d86016ae" />

---

### ✅ Service


- [svc.yaml](https://github.com/Sherif127/iVolve-OJT/blob/8d523068f8a2c607b6aefebf36650a877011686f/5-Kubernates/Lab24-Node.js-Application-Deployment-with-ClusterIP-service/svc.yaml)

🌐 Get ClusterIP Service

<img width="724" height="81" alt="Image" src="https://github.com/user-attachments/assets/9601516e-9979-4f17-8201-5adbc5ae481d" />

---

### ✅ Port Forward for Testing

```bash
kubectl port-forward svc/nodejs-service 8080:80 -n ivolve --address=0.0.0.0
```

📋 Application Logs

<img width="850" height="62" alt="Image" src="https://github.com/user-attachments/assets/e820b5f8-557c-4612-8b2f-c5fab0882a54" />

> ⚠️ **Note**: The Node.js app depends on a MySQL database, but the database is not created in this lab.  
> As a result, the application may fail to connect or function properly.  
> ✅ This issue will be resolved in **Lab 25**, where we use an **Init Container** to create the required database and user automatically.
---