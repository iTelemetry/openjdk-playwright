set -e

docker build -t itelemetry-openjdk-playwright:local-latest

cd test-project
mvn clean install

docker build -t itelemetry-openjdk-playwright-test:latest

cd ../
