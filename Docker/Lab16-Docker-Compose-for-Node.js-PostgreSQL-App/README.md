
# 🐳 Lab 16: Docker Compose for Node.js + PostgreSQL App

This project demonstrates how to use **Docker Compose** to set up a Node.js application with a PostgreSQL database as services.

---

## 🧾 Overview

- **Node.js App** is built from a local Dockerfile
- **PostgreSQL DB** uses the official lightweight `postgres:15-alpine` image
- Docker Compose handles service creation, networking, and volume management

---

## 📂 Project Structure

```
.
├── docker-compose.yml
├── Dockerfile
├── package.json
├── .env
└── src
    ├── app.js
    └── db.js
```

---

## ⚙️ Services Defined

### 1. **App (Node.js)**
- Built using the local `Dockerfile`
- Exposes port `3000`
- Depends on the database container to ensure startup order
- Uses custom Docker network `mynet`

### 2. **DB (PostgreSQL)**
- Image: `postgres:15-alpine`
- Runs on port `5432`
- Uses environment variables defined in `.env`:
  - `POSTGRES_USER=postgres`
  - `POSTGRES_PASSWORD=postgres`
  - `POSTGRES_DB=postgres`
- Mounts volume `postgres_data` for data persistence
- Connected to `mynet` network

---

## 📁 Volumes & Network

- **Volume:** `postgres_data` (for PostgreSQL data at `/var/lib/postgresql/data`)
- **Network:** `mynet` (Docker bridge network)

---

## 🚀 Usage

### 1. Clone the Repo

```bash
git clone https://github.com/Ibrahim-Adel15/docker6.git
cd docker6
```

### 2. Create `.env` File

```env
POSTGRES_USER=postgres
POSTGRES_PASSWORD=postgres
POSTGRES_DB=postgres
```

### 3. Build and Run

```bash
docker-compose up --build
```

### 4. Verify Containers

```bash
docker-compose ps
```

### 5. Test Container Communication
```bash
curl localhost:3000
```

✅ Expected Output:
```
PostgreSQL Connection Test App
```
![Image](https://github.com/user-attachments/assets/aa786c37-d431-4b80-b869-16dd99eeed8a)

---

## 📸 Screenshots

1. ✅ `docker-compose ps` showing both `app` and `db` containers running

![Image](https://github.com/user-attachments/assets/0e42513d-5ad5-4a0b-bb3d-2012edb20d7a)

2. ✅ Output of `docker volume ls` showing `docker6_postgres_data`

![Image](https://github.com/user-attachments/assets/2e16683f-a3e5-4b45-9fab-0c9dac24700d)

3. ✅ Output of `docker network ls` showing `docker6_mynet`

![Image](https://github.com/user-attachments/assets/5ae56ae9-d00e-47b5-809b-05f3bfad162e)

---

## 📌 Notes

- Make sure Docker and Docker Compose are installed
- Port `3000` must be free on your machine
- Data persists across container restarts thanks to Docker volumes

---