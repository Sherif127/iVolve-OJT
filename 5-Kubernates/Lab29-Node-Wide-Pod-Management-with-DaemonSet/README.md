# Lab 29 - Node-Wide Pod Management with DaemonSet and Prometheus Monitoring

This lab sets up a full Kubernetes monitoring solution using **Prometheus**, **Node Exporter** via **DaemonSet**, and Helm.  
You will verify metrics exposure and Prometheus target discovery.

## 📁 Project Structure

```
.
├── prometheus-values.yaml     # Custom values for Helm installation
├── namespace.yaml             # Namespace definition for monitoring
├── daemonset.yaml             # Custom DaemonSet for Node Exporter
├── README.md                  
```

## ✅ Steps

### 1. Create the Monitoring Namespace

```bash
kubectl apply -f namespace.yaml
```
  

### 2. Deploy Node Exporter as DaemonSet (Manual)

📄 `daemonset.yaml`:

```yaml
apiVersion: apps/v1
kind: DaemonSet
metadata:
  name: node-exporter
  namespace: monitoring
  labels:
    app: node-exporter
spec:
  selector:
    matchLabels:
      app: node-exporter
  template:
    metadata:
      labels:
        app: node-exporter
    spec:
      containers:
        - name: node-exporter
          image: quay.io/prometheus/node-exporter:latest
          ports:
            - containerPort: 9100
              hostPort: 9100
              protocol: TCP
          resources:
            requests:
              memory: 50Mi
              cpu: 50m
            limits:
              memory: 100Mi
              cpu: 100m
          volumeMounts:
            - name: proc
              mountPath: /host/proc
              readOnly: true
            - name: sys
              mountPath: /host/sys
              readOnly: true
            - name: root
              mountPath: /rootfs
              readOnly: true
      volumes:
        - name: proc
          hostPath:
            path: /proc
        - name: sys
          hostPath:
            path: /sys
        - name: root
          hostPath:
            path: /
      hostNetwork: true
      tolerations:
        - operator: "Exists"
```

```bash
kubectl apply -f daemonset.yaml
```

```bash
kubectl get pods -n monitoring -o wide
```
#### 📸: 
   <img width="1096" height="125" alt="Image" src="https://github.com/user-attachments/assets/83ca9c76-604c-4146-a373-5b16d23b566e" />
### 3. Verify Metrics Exposure

run:

```bash
curl http://<NODE-IP>:9100/metrics
```
✅ You should see a long list of Prometheus-formatted metrics like this.  
#### 📸: 
   <img width="1915" height="1022" alt="Image" src="https://github.com/user-attachments/assets/976256ce-847f-4fbe-a2d0-d6a40523a744" />

### 4. Deploy Prometheus via Helm

📄 `prometheus-values.yaml`:

```yaml

alertmanager:
  enabled: true
  persistentVolume:
    enabled: false

nodeExporter:
  enabled: true

pushgateway:
  enabled: true

server:
  enabled: true
  persistentVolume:
    enabled: false  
  service:
    type: NodePort   
    nodePort: 30090  
  resources:
    requests:
      cpu: 100m
      memory: 150Mi
    limits:
      cpu: 200m
      memory: 300Mi
```

```bash
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
helm install prometheus prometheus-community/prometheus -f prometheus-values.yaml -n monitoring
```
#### 📸 :
  <img width="761" height="686" alt="Image" src="https://github.com/user-attachments/assets/01683633-56d7-42fa-96e3-0762ed41b8e5" />

### 5. Expose Prometheus via NodePort

Prometheus is exposed on `NodePort 30090`.

```bash
kubectl get svc -n monitoring | grep prometheus
```

#### 📸 :                   
   <img width="1014" height="141" alt="Image" src="https://github.com/user-attachments/assets/0da6b045-ca4a-4595-bb4d-f4430b8ad3f1" />

Access Prometheus UI:  
```
http://<AnyNodeIP>:30090
```

### 6. Verify Prometheus Target Discovery

Prometheus UI → `Status > Targets` should show:

- `kubernetes-nodes` with 3/3 up
- `kubernetes-nodes-cadvisor`
- `prometheus-node-exporter`

#### 📸 :      <img width="1920" height="1033" alt="Image" src="https://github.com/user-attachments/assets/8536af8f-4654-4075-870a-2316311fef3f" />

---