# ---------- Stage 1: Build the JAR ----------
FROM maven:3.9-eclipse-temurin-17 AS builder

WORKDIR /app

# Copy everything and build the JAR
COPY . .
RUN mvn clean package -DskipTests

# ---------- Stage 2: Create minimal final image ----------
FROM openjdk:17-jdk-slim

WORKDIR /app

# Copy the JAR from the build stage
COPY --from=builder /app/target/*.jar app.jar

# Run the app
CMD ["java", "-jar", "app.jar"]