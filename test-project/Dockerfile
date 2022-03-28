FROM maven:3.8.4-eclipse-temurin-17 as build

COPY . /opt/build
WORKDIR /opt/build

CMD ["mvn", "clean", "install"]

FROM itelemetry-openjdk-playwright-test:latest

COPY --from=build /usr/src/target/playwright-test-project-*.jar /opt/app/playwright-test-project.jar

WORKDIR /opt/app

CMD ["java", "-jar", "/opt/app/playwright-test-project.jar"]