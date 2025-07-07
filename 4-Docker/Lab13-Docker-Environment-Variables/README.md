# 🐳  Lab13: Docker Environment Variables

This lab demonstrates how to work with **Docker Environment Variables** using a simple Flask app.

---

## 📁 Project Structure

```
.
├── app.py
├── Dockerfile
├── Dockerfile-env
└── env.var
```

---

## 🚀 What We Will Do

- Setting environment variables using:
  - `docker run -e`
  - `--env-file`
  - `ENV` in Dockerfile
- Running multiple containers with different configurations
- Verifying environment behavior via curl

---

## 🔧 Flask Application (`app.py`)

```python
from flask import Flask
import os

app = Flask(__name__)

@app.route('/')
def show_env():
    mode = os.getenv("APP_MODE", "default")
    region = os.getenv("APP_REGION", "unknown")
    return f"App mode: {mode}, Region: {region}"

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8080)
```

---

## 🛠️ Dockerfiles

### 🔹 `Dockerfile` – for runtime env variables

```dockerfile
FROM python:3
WORKDIR /app
COPY . .
RUN pip install flask
EXPOSE 8080
CMD ["python", "app.py"]
```

### 🔹 `Dockerfile-env` – embed env variables inside the image

```dockerfile
FROM python:3
WORKDIR /app
COPY . .
RUN pip install flask
ENV APP_MODE=production
ENV APP_REGION=canada-west
EXPOSE 8080
CMD ["python", "app.py"]
```

---

## 📦 Building Images

```bash
# Default build from Dockerfile
docker build -t flask-img .
```

![Image](https://github.com/user-attachments/assets/73d56b17-e5f2-40b2-ad1d-ee3168e5b699)

```bash
# Build from Dockerfile-env
docker build -f Dockerfile-env -t flask-img:v2 .
```

![Image](https://github.com/user-attachments/assets/07ecbaa7-b887-4d1c-b6cb-f7056541a29d)


![Image](https://github.com/user-attachments/assets/e8b3c309-49cd-42d3-8ef7-8fd087414b10)

---

## 🐋 Running Containers

### ✅ `container1` — Using `-e` flags

```bash
docker run -d --name container1 -p 8080:8080 \
  -e APP_MODE=development \
  -e APP_REGION=us-east \
  flask-img
```

### ✅ `container2` — Using `--env-file`

`env.var`:

```
APP_MODE=staging
APP_REGION=us-west
```

```bash
docker run -d --name container2 -p 9090:8080 \
  --env-file env.var \
  flask-img
```

### ✅ `container3` — Built-in ENV from Dockerfile

```bash
docker run -d --name container3 -p 7070:8080 flask-img:v2
```

![Image](https://github.com/user-attachments/assets/cac27f6c-b36f-4983-b96c-853c128c1a2b)

---

## 🧪 Test the Output

Using curl:

```bash
curl localhost:8080   # container1
curl localhost:9090   # container2
curl localhost:7070   # container3
```

### 🖼️ Output

![Image](https://github.com/user-attachments/assets/749e64ce-05f7-4e88-8474-48c164a91379)

---

| Container     | Method              | ENV Values                   | Port |
|---------------|---------------------|------------------------------|------|
| `container1`  | `-e` flags          | `development`, `us-east`     | 8080 |
| `container2`  | `--env-file`        | `staging`, `us-west`         | 9090 |
| `container3`  | `ENV in Dockerfile` | `production`, `canada-west`  | 7070 |

---