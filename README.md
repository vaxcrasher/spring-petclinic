

## Resolving JCenter Issues
* You will need to edit pom.xml to make the following changes:
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
* IntelliJ does NOT support JCenter and you will get three errors like this
  ```
    Error:(175, 21) Plugin 'org.springframework.boot:spring-boot-maven-plugin:' not found
    Error:(217, 18) Plugin 'pl.project13.maven:git-commit-id-plugin:' not found
    Error:(218, 21) Plugin 'pl.project13.maven:git-commit-id-plugin:' not found
  ```
  These can safely be ignored and code pushed to the repository anyway. The code will build correctly in Jenkins.

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
