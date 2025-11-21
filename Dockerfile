# Use Amazon Corretto 11 (OpenJDK 11)

FROM amazoncorretto:11

# Set working directory

WORKDIR /app

# Copy your Spring Boot JAR

COPY target/my-simple-app-0.0.1-SNAPSHOT.jar app.jar

# Expose the default Spring Boot port

EXPOSE 8080

# Run the app

ENTRYPOINT ["java","-jar","app.jar"]

