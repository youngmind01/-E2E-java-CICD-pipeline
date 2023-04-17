FROM maven:3-eclipse-temurin-8-alpine as build 
WORKDIR /app
COPY . .
RUN mvn install

FROM openjdk:19-jdk-alpine3.16
WORKDIR /app
COPY  --from=build /app/target/vprofile-1.0.1-SNAPSHOT.war /app/
EXPOSE 38080
CMD [ "java", "-war", "vprofile-1.0.1-SNAPSHOT.war" ]