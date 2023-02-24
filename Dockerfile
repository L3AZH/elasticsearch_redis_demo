FROM openjdk:17
ARG DB_PORT_FOR_DOCKER_FILE
ENV DB_PORT=$DB_PORT_FOR_DOCKER_FILE
WORKDIR ./
RUN mkdir ./root/demo-service
COPY ./build/libs/*.jar ./root/demo-service/app.jar
COPY ./wait-for-it.sh ./root/demo-service/wait-for-it.sh
ENTRYPOINT ./root/demo-service/wait-for-it.sh mysqldb:${DB_PORT} --timeout=100 -- java -jar ./root/demo-service/app.jar
