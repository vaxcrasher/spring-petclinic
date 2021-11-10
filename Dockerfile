# OpenJDK 11 Official Container
FROM openjdk:11

EXPOSE 8181

# copy jar to /usr/bin
COPY target/spring-petclinic-2.5.0-SNAPSHOT.jar /usr/bin/spring-petclinic.jar

# run the application from the jar
ENTRYPOINT ["java","-jar","/usr/bin/spring-petclinic.jar","--server.port=8181"]
