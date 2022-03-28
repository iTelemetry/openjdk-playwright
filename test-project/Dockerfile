FROM maven:3.8.4-eclipse-temurin-17 as build

COPY . /opt/build
WORKDIR /opt/build
RUN ["mvn", "clean", "install"]
RUN ["cp", "/usr/src/target/playwright-test-project-*.jar", "/usr/src/playwright-test-project.jar"]

CMD ["ls", "-l", "/usr/src"]

FROM itelemetry-openjdk-playwright:local-latest

COPY --from=build /usr/src/playwright-test-project.jar /opt/app/playwright-test-project.jar

WORKDIR /opt/app

CMD ["java", "-jar", "/opt/app/playwright-test-project.jar"]