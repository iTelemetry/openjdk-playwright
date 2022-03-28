FROM mcr.microsoft.com/playwright:v1.20.1-focal
FROM eclipse-temurin:17.0.2_8-jdk-focal

LABEL org.opencontainers.image.source = "https://github.com/iTelemetry/itelemetry-openjdk-playwright"

RUN apt update -y
RUN apt upgrade -y
RUN apt-get install openjdk-17-jdk -y

RUN adduser --system --group spring

USER spring:spring

ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/app/app.jar"]