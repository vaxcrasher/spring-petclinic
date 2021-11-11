pipeline {
  environment {
    registry = "vaxcrasher/spring-petclinic-docker"
    registryCredential = 'docker-hub'
    dockerImage = ''
  }
  agent any
  tools {
    maven 'Maven-3.8.3'
    jdk 'open-jdk-11'
  }
  stages {
    stage('Cloning Git') {
      steps {
        git url: 'https://github.com/vaxcrasher/spring-petclinic.git',
            branch: 'main'
      }
    }
    stage('Compile') {
       steps {
         sh 'mvn compile'
       }
    }
    stage('Test') {
      steps {
        sh '''
        mvn clean install
        ls
        pwd
        '''
      }
    }
    stage('Building Image') {
      steps{
        script {
          dockerImage = docker.build registry + ":latest"
        }
      }
    }
    stage('Deploy Image') {
      steps{
         script {
            docker.withRegistry( '', registryCredential ) {
            dockerImage.push()
          }
        }
      }
    }
    stage('Remove Unused docker image') {
      steps{
        sh "docker rmi $registry:latest"
      }
    }
  }
}
