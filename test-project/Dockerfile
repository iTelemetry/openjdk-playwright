FROM maven:3.8.4-eclipse-temurin-17 as build

COPY . /opt/build
WORKDIR /opt/build
RUN ["mvn", "clean", "install"]
RUN ["ls", "-l", "/opt/build"]
RUN ["ls", "-l", "/opt/build/target"]
RUN ["cp", "/opt/build/target/playwright-test-project-*.jar", "/opt/build/playwright-test-project.jar"]
RUN ["ls", "-l", "/opt/build"]

CMD ["ls", "-l", "/opt/build"]

FROM itelemetry-openjdk-playwright:local-latest

COPY --from=build /opt/build/playwright-test-project.jar /opt/app/playwright-test-project.jar

WORKDIR /opt/app

CMD ["java", "-jar", "/opt/app/playwright-test-project.jar"]