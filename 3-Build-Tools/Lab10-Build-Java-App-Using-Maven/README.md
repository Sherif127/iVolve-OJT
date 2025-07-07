# 🧪 Lab 10: Build Java Application using Maven

This project demonstrates how to build, test, and run a simple Java application using **Maven** .

---

## ⚙️ Environment Setup

### ✅ 1. Install Java 17
```bash
sudo dnf install java-17-openjdk-devel -y
```

### ✅ 2. Set JAVA_HOME
```bash
echo 'export JAVA_HOME=/usr/lib/jvm/java-17-openjdk' >> ~/.bashrc
source ~/.bashrc
```

### ✅ 3. Install Maven
```bash
sudo dnf install maven -y
```

### ✅ 4. Verify Installation
```bash
mvn -version
```
![Image](https://github.com/user-attachments/assets/98c1ca3f-feed-47fe-b981-b3de92b37edf)
---

## 📥 Clone the Project

```bash
git clone https://github.com/Ibrahim-Adel15/build2.git
cd build2
```

---

## 🗂️ Project Structure

```bash
├── pom.xml
└── src
    ├── main
    │   └── java
    │       └── com
    │           └── example
    │               └── App.java
    └── test
        └── java
            └── com
                └── example
                    └── AppTest.java

```

---

## 🧪 Running Unit Tests

```bash
mvn test
```

![Image](https://github.com/user-attachments/assets/6d7977c6-948b-4928-8b28-c71823da993c)

---

## 🛠 Build the Application

```bash
mvn package
```

📦 Output JAR will be located in:
```
target/hello-ivolve-1.0-SNAPSHOT.jar
```

![Image](https://github.com/user-attachments/assets/32d5eb3c-616b-4c35-a4b7-044dc7bc7e8e)

---

## 🚀 Run the Application

```bash
java -jar target/hello-ivolve-1.0-SNAPSHOT.jar
```

✅ Expected Output:
```
Hello iVolve Trainee
```

![Image](https://github.com/user-attachments/assets/fb03ec96-b489-4f82-a8aa-0ec8c32d9d75)

---

## 💡 Unit Test Insight

The unit test checks if the console output exactly matches:
```java
Hello iVolve Trainee
```

🔁 **Try this:**  
Edit the app to print:
```java
Hello iVolve Trainee Sherif
```
![Image](https://github.com/user-attachments/assets/d3f3fe63-ae80-4f49-baf1-2a31f0f898aa)

Then run:
```bash
mvn test
```

❌ Now the test will fail because the output does not match the expected string.

![Image](https://github.com/user-attachments/assets/15aeb49e-981f-4684-9b29-68efbc40c0d0)

---
