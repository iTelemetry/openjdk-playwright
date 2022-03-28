FROM maven:3.8.4-eclipse-temurin-17 as build

COPY . /opt/build
WORKDIR /opt/build
RUN ["mvn", "clean", "install"]

CMD ["ls", "-l", "/opt/build"]

FROM itelemetry-openjdk-playwright:local-latest

COPY --from=build /opt/build/target/playwright-test-project-*.jar /opt/app/playwright-test-project.jar

WORKDIR /opt/app

ENTRYPOINT ["java", "-jar", "/opt/app/playwright-test-project.jar"]