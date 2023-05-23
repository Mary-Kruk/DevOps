pipeline {
    agent any
    
    stages {
        stage('Checkout') {
            steps {
                // Checkout the code from your Git repository
                git 'https://github.com/Mary-Kruk/DevOps'
            }
        }
        
        stage('Build Docker Image') {
            steps {
                // Build the Docker image using the Dockerfile
                sh 'docker build -t your-image-name .'
            }
        }
    }
    
    post {
        always {
            script {
                // Clean up Docker resources
                sh 'docker image prune -f'
            }
        }
    }
}
