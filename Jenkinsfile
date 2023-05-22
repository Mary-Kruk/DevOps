pipeline {

    environment {
        PATH = "$PATH:/usr/local/bin/docker-compose"
    }

    agent any
    
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        
        stage('Build Docker Image') {
            steps {
                // Build the Docker image using the Dockerfile
                sh 'docker-compose up'
            }
        }
    }
}
