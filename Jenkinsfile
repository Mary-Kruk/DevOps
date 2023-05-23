pipeline {
    agent any
    
    stages {
        stage('Build Docker Image') {
            steps {
                // Build the Docker image using the Dockerfile
                sh 'docker-compose up -d'
            }
        }
    }
    
    post {
        always {
            script {
                sh 'docker-compose down -v'
                sh 'docker network prune -f'
            }
        }
    }
}
