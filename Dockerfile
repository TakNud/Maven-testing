# First Stage: Build the application
FROM maven:3.9.6-eclipse-temurin-17 AS builder

# Set working directory
WORKDIR /app

# Copy the Maven project files
COPY myapp/pom.xml .

# Download dependencies (layer caching)
RUN mvn dependency:go-offline

# Copy the source code
COPY myapp/src ./src

# Build the application
RUN mvn clean package -DskipTests

# Second Stage: Create a minimal runtime environment
FROM eclipse-temurin:17-jre

# Set non-root user
RUN addgroup --system myappgroup && adduser --system --group myappuser
USER myappuser

# Set working directory
WORKDIR /app

# Copy the JAR file from the builder stage
COPY --from=builder /app/target/*.jar app.jar

# Expose port 8080
EXPOSE 8080

# Run the application
CMD ["java", "-jar", "app.jar"]
