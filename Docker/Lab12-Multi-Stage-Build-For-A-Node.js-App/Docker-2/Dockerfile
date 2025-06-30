#stage1

FROM maven:3.9.10-eclipse-temurin-17 AS build

WORKDIR /app

COPY . .

RUN mvn package   





#stage2 

FROM eclipse-temurin:17-jdk-alpine

WORKDIR /app

COPY --from=build /app/target/demo-0.0.1-SNAPSHOT.jar app.jar

CMD ["java", "-jar", "app.jar"]

