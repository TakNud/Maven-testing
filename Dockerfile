# Stage 1: Build the application
FROM eclipse-temurin:17-jdk AS builder
ARG JAR_FILE
WORKDIR /app
COPY ${JAR_FILE} app.jar
RUN java -Djarmode=layertools -jar app.jar extract

# Stage 2: Create the runtime image
FROM eclipse-temurin:17-jre
WORKDIR /app

# Security: Create and use a non-root user
RUN addgroup --system myuser && adduser --system --ingroup myuser myuser

# Copy extracted layers from the builder stage
COPY --from=builder /app/dependencies/ ./dependencies/
COPY --from=builder /app/spring-boot-loader/ ./spring-boot-loader/
COPY --from=builder /app/snapshot-dependencies/ ./snapshot-dependencies/
COPY --from=builder /app/application/ ./application/

# Set ownership for security
RUN chown -R myuser:myuser /app

USER myuser
EXPOSE 8080

# Use layered startup for faster boot time
CMD ["java", "-cp", "dependencies:snapshot-dependencies:spring-boot-loader:application", "org.springframework.boot.loader.JarLauncher"]
