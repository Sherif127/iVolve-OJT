
# 🐳 Lab12: Multi-Stage Build For A Node.js App

This lab demonstrates how to build and run a Spring-Boot Application using a **multi-stage Dockerfile** to produce a lightweight and efficient production image.

---

## 📁 Project Structure

```
.
├── Dockerfile
├── pom.xml
└── src
    └── main
        └── java
            └── com
                └── example
                    └── demo
                        └── DemoApplication.java
```

---
## Clone the Repository

```bash
git clone https://github.com/Ibrahim-Adel15/Docker-1.git
cd Docker-1
```

## ⚙️ Dockerfile Breakdown

```dockerfile
# Stage 1: Build the application
FROM maven:3.9.10-eclipse-temurin-17 AS build
WORKDIR /app
COPY . .
RUN mvn package

# Stage 2: Create lightweight runtime image
FROM eclipse-temurin:17-jdk-alpine
WORKDIR /app
COPY --from=build /app/target/demo-0.0.1-SNAPSHOT.jar app.jar
CMD ["java", "-jar", "app.jar"]
```

- Stage 1 builds the JAR file using Maven.
- Stage 2 copies the JAR into a clean Alpine image for runtime.

---

## 🛠️ Build the Docker Image

```bash
docker build -t multistage-lab .
```

![Image](https://github.com/user-attachments/assets/35ffb44e-4ff1-40f3-a9ca-8edc25901a02)

---

## 🚀 Run the Container

```bash
docker run -d --name multistage-app -p 7070:8080 multistage-lab:latest
```

![Image](https://github.com/user-attachments/assets/f508ef4a-b324-462c-a420-c39c3a657295)
---

## 🔍 Test the Application

```bash
curl localhost:7070
```

Expected Output:

```
Hello from Dockerized Spring Boot!
```

![Image](https://github.com/user-attachments/assets/304556fd-8dfa-4bf1-8453-ccf10669d838)

---

## 📦 Image Size Comparison

### Comparison From Previous Lab 

| Image           | Base Image                         | Size  |
|------------------|-------------------------------------|--------|
| `lab1.1`         | maven:3.9.10-eclipse-temurin-17     | 567MB |
| `lab1.2`         | eclipse-temurin:17-jdk-alpine       | 352MB |
| `multistage-lab` | Multi-stage (build + alpine runtime)| 352MB |

![Image](https://github.com/user-attachments/assets/8e58dedf-f119-4331-9268-54bd246fcbd2)

---

## ✅ Conclusion

Using a **multi-stage Dockerfile** allows you to:
- Build your app with full tools (like Maven)
- Package only the final JAR into a minimal, production-ready image
- Reduce final image size significantly
- Improve build separation and security
