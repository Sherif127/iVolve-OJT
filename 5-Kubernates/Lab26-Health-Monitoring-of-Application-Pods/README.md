# Lab 26: Health Monitoring of Application Pods

## 🎯 Lab Objective

Configure health checks for a Kubernetes application using:

- ✅ **Readiness Probe** to determine when the application is ready to serve traffic.
- ✅ **Liveness Probe** to ensure the application is still running and healthy.

---

## 📦 Deployment Configuration

We used a Node.js application with a MySQL init container. Probes were added to the main application container.

```yaml
readinessProbe:
  httpGet:
    path: /ready
    port: 3000
  initialDelaySeconds: 15
  periodSeconds: 20
  timeoutSeconds: 2
  failureThreshold: 3
  successThreshold: 1

livenessProbe:
  httpGet:
    path: /health
    port: 3000
  initialDelaySeconds: 15
  periodSeconds: 20
  timeoutSeconds: 2
  failureThreshold: 3
  successThreshold: 1
```

---

### Apply the deployment

```bash
kubectl apply -f deployment.yaml
```

- [Deployment.yaml](https://github.com/Sherif127/iVolve-OJT/blob/main/5-Kubernates/Lab26-Health-Monitoring-of-Application-Pods/deployment.yaml)

---

### Monitor the rollout status

```bash
kubectl rollout status deployment/nodejs-app -n ivolve
```

#### 📸 Screenshot:

<img width="1000" height="144" alt="Image" src="https://github.com/user-attachments/assets/80ee873a-8bba-46dc-835e-3bfdb3d58e86" />

---

### Describe a pod to verify probes

```bash
kubectl describe pod <pod-name> -n ivolve
```

#### 📸 Screenshot:

<img width="1028" height="47" alt="Image" src="https://github.com/user-attachments/assets/943c8ca5-eb5f-4041-aed0-ac6c51034646" />

---
## 📝 Notes

- `readinessProbe`: Temporarily removes pod from service endpoints if it’s not ready.
- `livenessProbe`: Automatically restarts the pod if it becomes unresponsive.

---