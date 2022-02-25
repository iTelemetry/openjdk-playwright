FROM openjdk:17.0.1-buster

LABEL org.opencontainers.image.source = "https://github.com/iTelemetry/itelemetry-openjdk-playwright"

RUN adduser --system --group spring

RUN apt-get install curl tar bash procps git -y

ARG MAVEN_VERSION=3.8.4
ARG USER_HOME_DIR="/home/spring"
ARG BASE_URL=https://dlcdn.apache.org/maven/maven-3/${MAVEN_VERSION}/binaries

RUN mkdir -p /usr/share/maven /usr/share/maven/ref \
  && echo "Downloading maven" \
  && curl -fsSL -o /tmp/apache-maven.tar.gz ${BASE_URL}/apache-maven-${MAVEN_VERSION}-bin.tar.gz \
  \
  && echo "Unzipping maven" \
  && tar -xzf /tmp/apache-maven.tar.gz -C /usr/share/maven --strip-components=1 \
  \
  && echo "Cleaning and setting links" \
  && rm -f /tmp/apache-maven.tar.gz \
  && ln -s /usr/share/maven/bin/mvn /usr/bin/mvn

ENV MAVEN_HOME /usr/share/maven
ENV MAVEN_CONFIG "$USER_HOME_DIR/.m2"

ENV PLAYWRIGHT_BROWSERS_PATH=/ms-playwright
ENV PLAYWRIGHT_TMP_JAVA_PATH=/tmp/pw-java

RUN git clone https://github.com/microsoft/playwright-java.git $PLAYWRIGHT_TMP_JAVA_PATH
RUN mkdir $PLAYWRIGHT_BROWSERS_PATH && chmod -R 777 $PLAYWRIGHT_BROWSERS_PATH

RUN cd $PLAYWRIGHT_TMP_JAVA_PATH && \
    ./scripts/download_driver_for_all_platforms.sh && \
    mvn install -D skipTests --no-transfer-progress && \
    DEBIAN_FRONTEND=noninteractive mvn exec:java -e -D exec.mainClass=com.microsoft.playwright.CLI \
                     -D exec.args="install-deps" -f playwright/pom.xml --no-transfer-progress && \
    #mvn exec:java -e -D exec.mainClass=com.microsoft.playwright.CLI \
    #                 -D exec.args="install" -f playwright/pom.xml --no-transfer-progress && \
    rm -rf $PLAYWRIGHT_TMP_JAVA_PATH

USER spring:spring

ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/app/app.jar"]