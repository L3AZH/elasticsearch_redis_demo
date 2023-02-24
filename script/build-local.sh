#!/usr/bin/env bash

chmod +x ../gradlew;
cd ..;
./gradlew -q removeOldBuild;
./gradlew bootJar;
touch Dockerfile;
echo "FROM openjdk:17" > Dockerfile;

# shellcheck disable=SC2129
echo "ARG DB_PORT_FOR_DOCKER_FILE" >> Dockerfile;
echo 'ENV DB_PORT=$DB_PORT_FOR_DOCKER_FILE' >> Dockerfile;
echo "WORKDIR ./" >> Dockerfile;
echo "RUN mkdir ./root/demo-service" >> Dockerfile;
echo "COPY ./build/libs/*.jar ./root/demo-service/app.jar" >> Dockerfile;
echo "COPY ./wait-for-it.sh ./root/demo-service/wait-for-it.sh" >> Dockerfile;
echo 'ENTRYPOINT ./root/demo-service/wait-for-it.sh mysqldb:${DB_PORT} --timeout=100 -- java -jar ./root/demo-service/app.jar' >> Dockerfile;
