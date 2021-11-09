pipeline {
    agent { docker { image 'maven:3.3.3' } }
    stages {
        stage('build') {
            steps {
                sh 'mvn --version'
                sh 'mvn verify -e -X'
                sh 'echo "Hello World"'
            }
        }
    }
}
