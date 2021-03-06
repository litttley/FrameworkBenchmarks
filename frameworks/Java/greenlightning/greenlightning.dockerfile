FROM maven:3.5.4-jdk-10-slim as maven

WORKDIR /greenlightning    
COPY pom.xml pom.xml
COPY src src
RUN mvn clean install -q

FROM openjdk:10-jdk-slim
WORKDIR /greenlightning
COPY --from=maven /greenlightning/target/greenlightning-test.jar app.jar
CMD ["java", "-server", "-Xmx16g", "-XX:+UseNUMA", "-XX:+UseParallelGC", "-XX:+AggressiveOpts", "-jar", "app.jar"]
