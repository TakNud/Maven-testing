# 🏗 Stage 1: Build the application
FROM eclipse-temurin:17-jdk AS builder
WORKDIR /app

# Copy Maven project files
COPY pom.xml .
COPY src ./src

# Package the application (creates target/myapp-1.0-SNAPSHOT.jar)
RUN mvn clean package -DskipTests

# 🏗 Stage 2: Create the runtime image
FROM eclipse-temurin:17-jre
WORKDIR /app

# Create non-root user for security
RUN addgroup --system myuser && adduser --system --ingroup myuser myuser

# Copy JAR from builder stage
COPY --from=builder /app/target/myapp-1.0-SNAPSHOT.jar app.jar

# Set correct permissions
RUN chown -R myuser:myuser /app

USER myuser
EXPOSE 8080

CMD ["java", "-jar", "app.jar"]
