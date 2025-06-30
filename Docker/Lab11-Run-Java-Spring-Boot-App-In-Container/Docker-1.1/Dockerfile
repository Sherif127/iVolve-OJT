FROM maven:3.9.10-eclipse-temurin-17

WORKDIR /app

COPY . .

RUN mvn package

CMD ["java", "-jar", "target/demo-0.0.1-SNAPSHOT.jar"]

