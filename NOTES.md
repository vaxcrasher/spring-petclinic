#JFrog Notes

##Command line build/run 
See https://github.com/vaxcrasher/spring-petclinic#running-petclinic-locally

###Build
- ran "./mvnw package"
- JAVA_HOME not set warning
- Packages all download (and there were a LOT of packages)
- Build was successful

###Execute
- ran "java -jar target/*.jar" Response
- ERROR - failed to start because it couldn't bind to 8080. Of course it couldn't - Jenkins is already running there!
  - See https://www.baeldung.com/spring-boot-change-port - need to change the server.port property in application.properties
  - Put "server.port=8081" under the "Web" section, not that it really matters.
  - In source you can change this in /main/resources/application.properties
  - Need to rebuild after doing this
  - SUCCESS!


