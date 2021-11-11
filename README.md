# JFrog PetClinic Demonstration Project
This repository contains a copy of the Spring PetClinic application that has been modified
to be built with Jenkins and deployed as a Docker container.

## Environment
###Required Software
* MacOS 11.5.2 (Big Sur)
* VMware Fusion 12.1.2
* Ubuntu Linux 20.04.3
* Jenkins 2.303.2
* Docker 20.10.10
* IntelliJ IDEA 2021.2.3
* OpenJDK 11.0.11
* Apache Maven 3.6.3
* git 2.25.1
* GitKraken 8.1.1
* VS Code 1.62.1

###Configuration Process
1. Create an Ubuntu 20.04 VM using VMware with the following configuration:
   * Memory: 4gb
   * CPU count: 2
   * Drive space: 25gb
2. Install the following software in this order:
   * OpenJDK 11
   * Docker
   * Git
   * Gitkraken (git gui)
   * Apache Maven
   * IntelliJ IDEA (Java Development)
   * VS Code (simpler ID for editing)
   * Jenkins
3. Make sure Jenkins starts, runs as a service, and is available at http://localhost:8080
4. Install the required plugins (I just piicked everything that looked like it might
   be useful).
5. Create a snapshot of the VM before proceeding

## Tutorials
Did the "Build a Java App with Maven" tutorial (https://www.jenkins.io/doc/tutorials/build-a-java-app-with-maven/).
I selected this because it was closest to what we would be doing with the assignment.
* Created a repository in my Github account to contain tutorial code
* Had to figure out how to set up the credentials for Github in Jenkins

## PetClinic Review
I reviewed the PetClinic project prior to trying do anything in Jenkins to get a feel for how it worked
and how it built with Maven.
* Fork the https://github.com/spring-projects/spring-petclinic repository into my own Github account
* Review the readme and the code at a high level
* Try to do a build from the command line using Maven. This went relatively smoothly once I figured out
  how Maven worked. I also had to change the port that the application ran on as Jenkins was already
  running on 8080. Port was changed to 8081 after a bit of research in Google to figure out how this
  is done.
* Run the application from the command line and make sure I could log in to PetClinic and the UI worked.

## Jenkins Configuration
Jenkins required some additional setup. This was an iterative process that generally led to the 
following happening.
* Install plugins for Maven Pipeline and Docker
* Configure the OpenJDK JDK under Global Tool Configuration. This was required to make parts of Maven
  work correctly (thanks google).
* Configure the Maven installation under Global Tool Configuration. This was also required to get Maven
  to work correctly (thanks again google).
* Create credentials to connect to my DockerHub account (this required a token and the right user name)
* Create a new Multibranch Pipeline Item named "PetClinic"
  * Set up the Github connection (no credentials required - this is a public repo)

## Jenkinsfile Configuration and Build
I initially tried to create my own Jenkinsfile but I quickly figured out that I would need to go through 
quite a large number of tutorials in order to figure this out. Instead, I spent a bit of time searching
for examples of a Jenkinsfile that would do a Maven build of a Java application and then create a Docker
container from that build. This was successful and, after a couple hours of work, I had a Jenkinsfile
and a Dockerfile that worked. The files are in this repository, but in general they do the following:

### Jenkinsfile
* Set up an environment with connection info for DockerHub
* Clone the Git repo
* Compile the code to a JAR file
* Run the tests
* Create the Docker image and push to my DockerHub repository
* Clean up the old Docker image

### Dockerfile
* Use the offical OpenJDK Linux Docker Container
* Expose Port 8181
* Copy the JAR file into the container
* Set up the JAR to start and then listen on 8181

See the "Starting/Stopping Docker Container" section below for information on how to start/stop the
application using Docker.

## Switching to JCenter
The final task was to switch the application over to using JCenter. I haven't worked with JCenter before
but a bit of research showed me that I needed to change two sections pom.xml. The changes are:
  * Comment out the ```<repositories>...</repositories>``` and ```<pluginRepositories>...</pluginRepositories>``` sections starting around line 280.
  * Add the following code to use the JCenter repository instead:
    ```
      <repositories>
        <repository>
          <id>central</id>
          <name>bintray</name>
          <url>https://jcenter.bintray.com</url>
          <snapshots>
            <enabled>false</enabled>
          </snapshots>
        </repository>
      </repositories>
    
      <pluginRepositories>
        <pluginRepository>
          <id>central</id>
          <name>bintray-plugins</name>
          <url>https://jcenter.bintray.com</url>
          <snapshots>
            <enabled>false</enabled>
          </snapshots>
        </pluginRepository>
      </pluginRepositories>
    ```

### Build issue in IntelliJ
After making these changes in IntelliJ I tried to commit the code to Git and ran into the three errors:
```
  Error:(175, 21) Plugin 'org.springframework.boot:spring-boot-maven-plugin:' not found
  Error:(217, 18) Plugin 'pl.project13.maven:git-commit-id-plugin:' not found
  Error:(218, 21) Plugin 'pl.project13.maven:git-commit-id-plugin:' not found
```
Some research showed that IntellIJ does not actually support JCenter and that it will throw strange
errors if you try to configure pom.xml to use JCenter. 

Based on the fact that the configuration for using JCenter in pom.xml was simple and well documented (the
code above came directly from JCenter documentation) I decided to push the code to Git and then try to
run the pipeline in Jenkins. This ended up working with no issues, and I now had a configuration that
met all of the mandatory requirements in the "Build a pipleine" task of the assignment!

## SUCCESS!
Time to clean up my repo a bit and write this document.

## Starting/Stopping Docker Container
* Start Container
  ```
    docker rm spring-petclinic-container
    docker pull vaxcrasher/spring-petclinic-container
    docker run -d name spring-petclinic-container -p 8181:8181 vaxcrasher/spring-petclinic-container
   ```
* Stop Container
  ```
    docker stop spring-petclinic-container
  ```
* PetClinic URL: http://localhost:8181

## Using JFrog Artifactory
I successfully set up JFrog Artifactory on my VM, but it is rather resource intensive and I had a hard
time actually doing anything with it. I will revisit it, but if this section is still in this document I 
was unable to get it to work.
