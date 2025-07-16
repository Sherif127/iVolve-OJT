
# Lab 31: Securing Kubernetes with RBAC and Service Accounts

## 🎯 Objective

This lab secures access to Kubernetes resources using:
- ServiceAccount (`jenkins-sa`)
- Role with limited permissions (`get`, `list` on pods)
- RoleBinding to connect the Role with the ServiceAccount
- Generating a custom `kubeconfig` to verify restricted access

---

## 📁 Files Structure

```
├── jenkins-sa-kubeconfig
├── sa.yaml
├── secret.yaml
├── role.yaml
├── rolebinding.yaml
└── README.md
```

---

## 🧩 Step-by-Step Instructions

### ✅ 1. Create Service Account

```yaml
# sa.yaml
apiVersion: v1
kind: ServiceAccount
metadata:
  name: jenkins-sa
  namespace: ivolve
```

```bash
kubectl apply -f sa.yaml
```

---

### ✅ 2. Create Secret Token for the Service Account

```yaml
# secret.yaml
apiVersion: v1
kind: Secret
metadata:
  name: jenkins-sa-token
  namespace: ivolve
  annotations:
    kubernetes.io/service-account.name: jenkins-sa
type: kubernetes.io/service-account-token
```

```bash
kubectl apply -f secret.yaml
```

---

### ✅ 3. Define Role with Read-Only Access to Pods

```yaml
# role.yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  namespace: ivolve
  name: pod-reader
rules:
- apiGroups: [""]
  resources: ["pods"]
  verbs: ["get", "list"]
```

```bash
kubectl apply -f role.yaml
```

---

### ✅ 4. Bind Role to ServiceAccount

```yaml
# rolebinding.yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: read-pods-binding
  namespace: ivolve
subjects:
- kind: ServiceAccount
  name: jenkins-sa
  namespace: ivolve
roleRef:
  kind: Role
  name: pod-reader
  apiGroup: rbac.authorization.k8s.io
```

```bash
kubectl apply -f rolebinding.yaml
```

---

### ✅ 5. Verify Permissions Using `kubectl auth can-i`

```bash
kubectl auth can-i list pods --as=system:serviceaccount:ivolve:jenkins-sa -n ivolve
# Output: yes

kubectl auth can-i create pods --as=system:serviceaccount:ivolve:jenkins-sa -n ivolve
# Output: no
```

#### 📸 <img width="1322" height="82" alt="Image" src="https://github.com/user-attachments/assets/b96ebb83-1ddd-4111-abfa-61bd5ce9c55c" />

---

## ⭐ Bonus: Generate `kubeconfig` for Jenkins Service Account

### 🔸 Get Required Values

```bash
NAMESPACE=ivolve
SA_NAME=jenkins-sa
SECRET_NAME=$(kubectl get secret -n $NAMESPACE | grep $SA_NAME | awk '{print $1}')
TOKEN=$(kubectl get secret $SECRET_NAME -n $NAMESPACE -o jsonpath="{.data.token}" | base64 -d)
CA_CERT=$(kubectl get secret $SECRET_NAME -n $NAMESPACE -o jsonpath="{.data['ca\.crt']}")
CLUSTER_NAME=$(kubectl config view --minify -o jsonpath='{.clusters[0].name}')
CLUSTER_SERVER=$(kubectl config view --minify -o jsonpath='{.clusters[0].cluster.server}')
```

### 🔸 Create `jenkins-sa-kubeconfig` file

```bash
cat <<EOF > jenkins-sa-kubeconfig
apiVersion: v1
kind: Config
clusters:
- name: ${CLUSTER_NAME}
  cluster:
    server: ${CLUSTER_SERVER}
    certificate-authority-data: ${CA_CERT}
contexts:
- name: ${SA_NAME}@${CLUSTER_NAME}
  context:
    cluster: ${CLUSTER_NAME}
    namespace: ${NAMESPACE}
    user: ${SA_NAME}
current-context: ${SA_NAME}@${CLUSTER_NAME}
users:
- name: ${SA_NAME}
  user:
    token: ${TOKEN}
EOF
```

---

### 🔸 Test Access With the New kubeconfig

```bash
KUBECONFIG=jenkins-sa-kubeconfig kubectl get pods -n ivolve
KUBECONFIG=jenkins-sa-kubeconfig kubectl get deployments -n ivolve  # Should be denied
```

#### 📸 <img width="1587" height="161" alt="Image" src="https://github.com/user-attachments/assets/1546cc5c-e16f-4141-9f84-1fd1e38ba30e" />

---

## ✅ Result

- ✅ Jenkins service account created
- ✅ RBAC applied successfully with limited access
- ✅ Verified access using custom kubeconfig

---