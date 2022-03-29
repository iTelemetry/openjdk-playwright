set -e

docker build -t itelemetry-openjdk-playwright:local-latest

cd test-project
mvn clean install

docker build -t itelemetry-openjdk-playwright-test:latest

cd ../

docker run -t --mount type=bind,source=/root/dev/itelemetry-openjdk-playwright/test-project/target/screenshot,target=/app/screenshot/ itelemetry-openjdk-playwright-test:latest
