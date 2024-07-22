FROM maven:latest as builder
MAINTAINER Shubham Lad
WORKDIR /java/
COPY pom.xml /java/
COPY src /java/src/
RUN mvn clean package

FROM alpine:latest
MAINTAINER Shubham Lad
USER root
RUN apk update && \
    apk add openjdk17

COPY --from=builder /java/target/salary.jar /app/salary.jar
COPY ./config.yaml /root/config/config.yaml
ENV CONFIG_FILE "/root/config/config.yaml"
EXPOSE 8080
ENTRYPOINT ["/usr/bin/java", "-jar", "/app/salary.jar"]
