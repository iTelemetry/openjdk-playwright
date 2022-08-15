FROM mcr.microsoft.com/playwright:v1.24.0-focal

LABEL org.opencontainers.image.source = "https://github.com/iTelemetry/openjdk-playwright"

RUN apt-get update -y
RUN apt-get upgrade -y
RUN apt-get install openjdk-17-jdk -y

RUN adduser --system --group java

RUN mkdir -p /app
RUN chown java /app

USER java:java

ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/app/app.jar"]