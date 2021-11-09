pipeline {
    agent { docker { image 'maven:3.3.3' } }
    stages {
        stage('build') {
            git url: 'https://github.com/vaxcrasher/spring-petclinic'
            withMaven {
                sh "mvn clean verify"
            }
        }
    }
}
