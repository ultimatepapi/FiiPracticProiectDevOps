FROM gradle:7.3-jdk11 AS build
WORKDIR /app
COPY springboot /app
RUN chmod +x ./gradlew && ./gradlew build --no-daemon
FROM openjdk:11-jre-slim
WORKDIR /app
COPY --from=build /app/build/libs/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]

