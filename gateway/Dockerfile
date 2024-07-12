# Stage 1: Build
FROM maven:3.8.5-openjdk-17 AS build

COPY settings.xml /root/.m2/settings.xml

WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

# Stage 2: Package
FROM openjdk:17-jdk-slim

RUN useradd -m springuser

WORKDIR /app
COPY --from=build /app/target/*.jar app.jar

RUN chown -R springuser:springuser /app

USER springuser

EXPOSE ${GATEWAY_PORT}
ENTRYPOINT ["java", "-jar", "app.jar"]