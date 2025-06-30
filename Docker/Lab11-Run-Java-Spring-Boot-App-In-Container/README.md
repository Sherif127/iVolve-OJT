
# Lab 11: Run Java Spring Boot App in a Docker Container

## 🔗 Lab Instructions Summary

> Clone the Java Spring Boot project and run it inside a Docker container.

---

### ✅ 1. Clone the Repository

```bash
git clone https://github.com/Ibrahim-Adel15/Docker-1.git
cd Docker-1
```

---

### ✅ 2. Create Dockerfile (Build Inside Container Version)

**Dockerfile (Docker-1):**

```Dockerfile
FROM maven:3.9.10-eclipse-temurin-17

WORKDIR /app

COPY . .

RUN mvn package

CMD ["java", "-jar", "target/demo-0.0.1-SNAPSHOT.jar"]
```

![Image](https://github.com/user-attachments/assets/6e1a3147-603b-4ae5-9f61-2a5345d6bde3)

---

### ✅ 3. Build and Run the Container

```bash
docker images
```
![Image](https://github.com/user-attachments/assets/222e84c2-73c7-44d7-ba4a-89332d11956a)


```bash
docker build -t lab1.1 .
```
![Image](https://github.com/user-attachments/assets/c7ec4be1-16cc-42c2-b3d9-ef866e67aa5c)

```bash
docker run -d --name app1.1 -p 8080:8080 lab1.1
curl localhost:8080
```

![Image](https://github.com/user-attachments/assets/de553916-43fd-475f-ae15-a40dda2f643e)

---

## 🔁 Second Attempt (Build App Locally First)

### ✅ 4. Copy Project and Build Locally

```bash
cp -r Docker-1 Docker-1.2
cd Docker-1.2
mvn package
```

---

### ✅ 5. Create Lightweight Dockerfile (Alpine + Prebuilt Jar)

**Dockerfile (Docker-1.2):**

```Dockerfile
FROM eclipse-temurin:17-jdk-alpine

WORKDIR /app

COPY . .

CMD ["java", "-jar", "target/demo-0.0.1-SNAPSHOT.jar"]
```

![Image](https://github.com/user-attachments/assets/e99c047b-29b5-40ae-ae00-3bea08bc019d)
---

### ✅ 6. Build and Run Container

```bash
docker build -t lab1.2 .
```
![Image](https://github.com/user-attachments/assets/f9da26b9-33eb-4f5b-81c6-416edbfab10e)


```bash
docker run -d --name app1.2 -p 9090:8080 lab1.2
curl localhost:9090
```

![Image](https://github.com/user-attachments/assets/3ca09ab1-1325-422e-a7f1-3f39a8761c91)

---
### Show Running Containers
```bash
docker ps
```
![Image](https://github.com/user-attachments/assets/182b6218-89f7-4f98-bb28-2a026a9b4051)

---
## 📁 Project Structure

```bash
Docker-1
├── Dockerfile
├── Dockerfile1.2
├── pom.xml
└── src
    └── main
        └── java
            └── com
                └── example
                    └── demo
                        └── DemoApplication.java


Docker-1.2
├── Dockerfile
├── pom.xml
├── src
│   └── main
│       └── java
│           └── com
│               └── example
│                   └── demo
│                       └── DemoApplication.java
└── target
    ├── classes
    │   └── com
    │       └── example
    │           └── demo
    │               └── DemoApplication.class
    ├── demo-0.0.1-SNAPSHOT.jar
    ├── demo-0.0.1-SNAPSHOT.jar.original
    ├── generated-sources
    │   └── annotations
    ├── maven-archiver
    │   └── pom.properties
    └── maven-status
        └── maven-compiler-plugin
            └── compile
                └── default-compile
                    ├── createdFiles.lst
                    └── inputFiles.lst
```

---

## 📊 Comparison Between Both Images

| Image   | Built Inside Container | Base Image                  | Size  |
|---------|------------------------|-----------------------------|-------|
| lab1.1  | Yes                    | maven:3.9.10-eclipse-temurin-17 | 567MB |
| lab1.2  | No (JAR prebuilt)      | eclipse-temurin:17-jdk-alpine  | 352MB |

![Image](https://github.com/user-attachments/assets/245c94f5-bcfb-4a5e-9c48-9695ed9fd336)

📝 **Conclusion:**  
- Building the JAR inside the image (lab1.1) results in a **larger image** because it includes Maven and all build dependencies.  
- Prebuilding the JAR and using a lightweight base image (lab1.2) gives a **smaller, cleaner production-ready image**.