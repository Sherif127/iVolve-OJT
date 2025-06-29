# 🧪 Lab 9: Build Java Application using Gradle

This project demonstrates how to build, test, and run a simple Java application using **Gradle** .

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

### ✅ 3. Install Gradle 8.7 Manually
```bash
wget https://services.gradle.org/distributions/gradle-8.7-bin.zip -P /tmp
sudo unzip -d /opt/gradle /tmp/gradle-8.7-bin.zip
echo "export PATH=\$PATH:/opt/gradle/gradle-8.7/bin" | sudo tee /etc/profile.d/gradle.sh
sudo chmod +x /etc/profile.d/gradle.sh
source /etc/profile.d/gradle.sh
```

### ✅ 4. Verify Installation
```bash
gradle -v
```
![Image](https://github.com/user-attachments/assets/ee7cd74b-b3d1-4f8d-bfa8-28bae117d8a9)
---

## 📥 Clone the Project

```bash
git clone https://github.com/Ibrahim-Adel15/build1.git
cd build1
```

---

## 🗂️ Application Structure before Build

```bash
├── build
│   ├── classes
│   │   └── java
│   │       └── main
│   │           └── com
│   │               └── ivolve
│   │                   └── App.class
│   ├── reports
│   │   └── problems
│   │       └── problems-report.html
│   └── tmp
│       └── compileJava
│           └── previous-compilation-data.bin
├── build.gradle
├── settings.gradle
└── src
    ├── main
    │   └── java
    │       └── com
    │           └── ivolve
    │               └── App.java
    └── test
        └── java
            └── com
                └── ivolve
                    └── AppTest.java

```

---

## 🧪 Running Unit Tests

```bash
gradle test
```
![Image](https://github.com/user-attachments/assets/0cca9298-36a7-491b-9568-63bf083f13a3)

🧾 Or you can view the HTML test report here:
```
build/reports/tests/test/index.html
```


---

## 🛠 Build the Application

```bash
gradle build
```

![Image](https://github.com/user-attachments/assets/d6416679-fddb-4be4-90f0-30dcb38b420a)

---

## 📦 Output Structure After Build

```bash
├── build
│   ├── classes
│   │   └── java
│   │       ├── main
│   │       │   └── com
│   │       │       └── ivolve
│   │       │           └── App.class
│   │       └── test
│   │           └── com
│   │               └── ivolve
│   │                   └── AppTest.class
│   ├── distributions
│   │   ├── build1-1.0.tar
│   │   └── build1-1.0.zip
│   ├── generated
│   │   └── sources
│   │       ├── annotationProcessor
│   │       │   └── java
│   │       │       ├── main
│   │       │       └── test
│   │       └── headers
│   │           └── java
│   │               ├── main
│   │               └── test
│   ├── libs
│   │   └── ivolve-app.jar
│   ├── reports
│   │   ├── problems
│   │   │   └── problems-report.html
│   │   └── tests
│   │       └── test
│   │           ├── classes
│   │           │   └── com.ivolve.AppTest.html
│   │           ├── css
│   │           │   ├── base-style.css
│   │           │   └── style.css
│   │           ├── index.html
│   │           ├── js
│   │           │   └── report.js
│   │           └── packages
│   │               └── com.ivolve.html
│   ├── scripts
│   │   ├── build1
│   │   └── build1.bat
│   ├── test-results
│   │   └── test
│   │       ├── binary
│   │       │   ├── output.bin
│   │       │   ├── output.bin.idx
│   │       │   └── results.bin
│   │       └── TEST-com.ivolve.AppTest.xml
│   └── tmp
│       ├── compileJava
│       │   ├── compileTransaction
│       │   │   ├── backup-dir
│       │   │   └── stash-dir
│       │   │       └── App.class.uniqueId0
│       │   └── previous-compilation-data.bin
│       ├── compileTestJava
│       │   └── previous-compilation-data.bin
│       ├── jar
│       │   └── MANIFEST.MF
│       └── test
├── build.gradle
├── settings.gradle
└── src
    ├── main
    │   └── java
    │       └── com
    │           └── ivolve
    │               └── App.java
    └── test
        └── java
            └── com
                └── ivolve
                    └── AppTest.java
  ```

---

## 🚀 Run the Application

```bash
java -jar build/libs/ivolve-app.jar
```

✅ Expected Output:
```
Hello iVolve Trainee
```

![Image](https://github.com/user-attachments/assets/c79549a4-b4a8-4a12-a61c-c166d119d399)

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

Then run:
```bash
gradle test
```

❌ Now the test will fail because the output does not match the expected string.

![Image](https://github.com/user-attachments/assets/07b17abb-8110-4988-9583-28dd1f11f47d)

---

## 🔍 Generate a Build Scan

```bash
gradle test --scan
```
![Image](https://github.com/user-attachments/assets/d5be9767-cde3-450c-bc15-22187785d155)
🔗 scan URL here : https://gradle.com/s/hukuzirglriw2


Use this scan to analyze:
- Task execution time
- Deprecation warnings
- Test performance and failure causes

---
