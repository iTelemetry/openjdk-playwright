FROM mcr.microsoft.com/playwright:v1.20.1-focal

LABEL org.opencontainers.image.source = "https://github.com/iTelemetry/itelemetry-openjdk-playwright"

RUN apt-get update -y
RUN apt-get upgrade -y
RUN apt-get install openjdk-18-jdk -y

RUN adduser --system --group java

RUN mkdir -p /app
RUN chown java /app

USER java:java

ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/app/app.jar"]