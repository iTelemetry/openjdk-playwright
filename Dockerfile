FROM mcr.microsoft.com/playwright:v1.20.1-focal

LABEL org.opencontainers.image.source = "https://github.com/iTelemetry/itelemetry-openjdk-playwright"

RUN apt-get update -y
RUN apt-get upgrade -y
RUN apt-get install openjdk-17-jdk -y

RUN adduser --system --group spring

RUN mkdir -p /app
RUN chown spring /app

USER spring:spring

ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/app/app.jar"]