FROM eclipse-temurin:17-jre
ARG JAR_FILE
COPY ${JAR_FILE} app.jar
RUN addgroup --system myuser && adduser --system --ingroup myuser myuser
USER myuser
CMD ["java", "-jar", "app.jar"]