pipeline {
    agent any
    tools {
        maven 'Maven 3.2.1'
        jdk 'jdk8'
    }
    stages {
        stage ('Initialize') {
            steps {
                sh '''
                    echo "PATH = ${PATH}"
                    echo "M2_HOME = ${M2_HOME}"
                '''
            }
        }

        stage ('Build') {
            steps {
                sh 'mvn install -Dmaven.test.skip=true'
            }
        }
    }
}