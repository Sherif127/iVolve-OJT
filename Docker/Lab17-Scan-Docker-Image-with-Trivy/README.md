
# 🐳 Lab 17: Scan Docker Image with Trivy

This lab demonstrates how to scan a Docker image for vulnerabilities using **Trivy**, and how to push it to your Docker Hub account.

---

## 🔧 Steps

### ✅ 1. Install Trivy
Install Trivy by following the instructions at:
👉 https://trivy.dev/latest/getting-started/installation/

---

### ✅ 2. Clone the Application Code
```bash
git clone https://github.com/Ibrahim-Adel15/Docker-1.git
```


---

### ✅ 3. Write `Dockerfile`
```bash
#stage1

FROM maven:3.9.10-eclipse-temurin-17 AS build

WORKDIR /app

COPY . .

RUN mvn package


#stage2

FROM eclipse-temurin:17-jdk-alpine

WORKDIR /app

COPY --from=build /app/target/demo-0.0.1-SNAPSHOT.jar app.jar

EXPOSE 8080

CMD ["java", "-jar", "app.jar"]
```

**Directory Structure**:
```bash
.
├── Dockerfile
├── pom.xml
├── src
│   └── main
│       └── java
│           └── com
│               └── example
│                   └── demo
│                       └── DemoApplication.java
└── test_img_output.json
```

---

### ✅ 4. Build Docker Image
```bash
docker build -t test-img .
```

![Image](https://github.com/user-attachments/assets/1f382d92-f042-47c5-925d-0c45d5484f51)

---

### ✅ 5. Scan Image and Output as JSON
```bash
trivy image --format json -o test_img_output.json test-img
```

![Image](https://github.com/user-attachments/assets/397dc7b6-ffde-4710-8fe1-988c2531142a)

---

### ✅ 6. Push Image to DockerHub
```bash
docker login
docker tag test-img <your-username>/test-img:v1
docker push <your-username>/test-img:v1
```

![Image](https://github.com/user-attachments/assets/e4146bcf-30a9-4aec-af69-b6daeda3ed0b)

![Image](https://github.com/user-attachments/assets/77f1aee4-3f81-457f-880d-8d37e93e5dda)

---

## 📄 Output
- JSON vulnerability report: [test_img_output.json](Docker/Lab17-Scan-Docker-Image-with-Trivy/Docker-1/test_img_output.json)


---