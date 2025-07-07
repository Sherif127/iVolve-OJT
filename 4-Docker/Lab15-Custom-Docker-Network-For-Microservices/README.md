
# 🐳 Lab 15: Custom Docker Network for Microservices

This lab demonstrates how to build a basic microservices architecture using Docker and a custom network. It includes two simple Flask applications: a backend service and a frontend that communicates with it.

---

## 📁 Project Structure

```
Docker5/
├── backend
│   ├── app.py
│   └── Dockerfile
└── frontend
    ├── app.py
    ├── Dockerfile
    └── requirements.txt
```

---

## 🔧 Step-by-Step Guide

### 1. Clone the repository

```bash
git clone https://github.com/Ibrahim-Adel15/Docker5.git
cd Docker5
```

---

### 2. Build Docker Images From Dockerfiles

### 📂 frontend/Dockerfile

```dockerfile
FROM python:3.9

WORKDIR  /app

COPY . .

RUN pip install -r requirements.txt

EXPOSE 5000

CMD ["python", "app.py"]
```

---

### 📂 backend/Dockerfile

```dockerfile
FROM python:3.9

WORKDIR /app

COPY . .

RUN pip install flask

EXPOSE 5000

CMD ["python", "app.py"]
```
#### Frontend

```bash
cd frontend
docker build -t frontend-img .
cd ..
```

#### Backend

```bash
cd backend
docker build -t backend-img .
cd ..
```

---

### 3. Create a Custom Docker Network

```bash
docker network create ivolve-network
```

---

### 4. Run Containers on the Custom Network

```bash
docker run -d --name backend1 --network ivolve-network backend-img
docker run -d --name frontend1 --network ivolve-network frontend-img
docker run -d --name frontend2 frontend-img  # This one uses the default network
```

---

### 5. Test Container Communication

#### From frontend1 (same network):

```bash
docker exec -it frontend1 sh
curl backend1:5000
```

✅ Expected: `Hello from Backend!`

#### From frontend2 (different network):

```bash
docker exec -it frontend2 sh
curl backend1:5000
```

❌ Expected: `Could not resolve host:backend1`

---

## 📸 Screenshots

### 1. Docker Network Created
![Image](https://github.com/user-attachments/assets/7021fe30-ad96-4c82-87c9-89126688cb32)

### 2. Running Containers
![Image](https://github.com/user-attachments/assets/f327e875-238e-482a-82f1-1bd1f0d23a6e)

### 3. Successful curl from frontend1
![Image](https://github.com/user-attachments/assets/a4cf6ad0-2e40-464e-aeb8-b28840e076c1)

### 4. Failed curl from frontend2
![Image](https://github.com/user-attachments/assets/65270237-03fd-4b9a-bf23-d49517e648e3)

---

## 📌 Notes

- Containers on the same Docker network can communicate using container names as DNS hostnames.
- Containers on different networks **cannot** resolve each other unless connected manually.

---

## 🧹 Clean Up

```bash
docker rm -f backend1 frontend1 frontend2
docker network rm ivolve-network
```

---