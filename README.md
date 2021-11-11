

## Starting/Stopping Docker Container
* Start Container
  ```
    docker pull vaxcrasher/spring-petclinic-container
    docker run -d name spring-petclinic-container -p 8181:8181 vaxcrasher/spring-petclinic-container
   ```
* Stop Container
  ```
    docker stop spring-petclinic-container
  ```
* PetClinic URL: http://localhost:8181
