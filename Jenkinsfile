pipeline {
    agent any
    
    stages {
        stage('Build Docker Image') {
            steps {
                // Build the Docker image using the Dockerfile
                 sh '/usr/local/bin/docker compose up'

            }
        }
    }
    
    post {
        always {
            script {
                //command that stops Docker Compose and removes containers including saved data (-v).
                sh 'docker-compose down -v'
                //a command that removes unused Docker networks (-f for no-questions-asked confirmation).
                sh 'docker network prune -f'
            }
        }
    }
}
