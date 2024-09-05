FROM ubuntu:latest AS build

RUN apt-get update && apt-get install openjdk-17-jdk -y

RUN apt-get install maven -y

WORKDIR /pessoa-api

COPY . /pessoa-api

RUN mvn clean install -Dmaven.test.skip=true

FROM openjdk:17-jdk-slim

EXPOSE 8080

COPY --from=build /pessoa-api/target/pessoaapi-0.0.1-SNAPSHOT.jar app.jar

ENTRYPOINT [ "java", "-jar", "app.jar" ]
