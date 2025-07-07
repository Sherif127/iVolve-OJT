# Lab 18: Containerized Node.js and MySQL Stack Using Docker Compose

## 📌 Objective
Containerize a full-stack Node.js application with a MySQL backend using **Docker Compose**.

---

## 🗂️ Project Structure

```bash
├── Dockerfile
├── db.js
├── docker-compose.yml
├── frontend
│ ├── assets
│ │ └── ivolve-logo.png
│ └── index.html
├── package.json
└── server.js
```

---

## 🔄 Clone the Application

```bash
git clone https://github.com/Ibrahim-Adel15/kubernets-app.git
cd kubernets-app
```

## ⚙️ Environment Setup

🐳 Run the Application
1. Build and run containers:
```bash
docker compose up -d --build
```

<img width="893" height="453" alt="Image" src="https://github.com/user-attachments/assets/29a05a9b-ddc6-4b7c-8585-6cf3f053df54" />

2. Check application endpoints:

```bash
curl http://localhost:3000
curl http://localhost:3000/health
curl http://localhost:3000/ready
```

<img width="1920" height="1024" alt="Image" src="https://github.com/user-attachments/assets/3e88af99-61e4-453c-9422-d6de4c8cd6d2" />

<img width="1920" height="1014" alt="Image" src="https://github.com/user-attachments/assets/357b22f3-ce3d-43d8-9344-cec671483569" />

<img width="1920" height="1028" alt="Image" src="https://github.com/user-attachments/assets/7cc9f614-f4bd-4aaa-a073-5f129f66685e" />

3. View application logs:
```bash
docker compose exec app cat /app/logs/access.log
```

<img width="908" height="290" alt="Image" src="https://github.com/user-attachments/assets/84c46782-4df4-4f56-b8e4-e3316646eef0" />

🐙 Push Docker Image to Docker Hub 

# Tag your image
```bash
docker tag 9966d43d779d <docker-username>/k8s-app:v1.2
```

# Login and push
```bash
docker login
docker push <docker-username>/k8s-app:v1.2
```
<img width="1529" height="363" alt="Image" src="https://github.com/user-attachments/assets/8f1f763b-768f-43af-886b-998d33c90aba" />

✅ Expected Output
After running the app, you should see:

✅ Connected to MySQL and 'ivolve' DB found.
🚀 Server started on http://localhost:3000



