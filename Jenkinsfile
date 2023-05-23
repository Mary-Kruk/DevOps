pipeline {
  agent any
 
  environment {
    DOCKER_REGISTRY = "DockerRegistry.com"
    DOCKER_REGISTRY_CREDENTIALS = credentials("DockerRegistry_Credentials")
  }
 
  stages {
    stage('Checkout stage') {
      steps {
        checkout scm
      }
    }
 
    stage('Docker images pushing & building stage') {
      steps {
        sh 'docker-compose build'
        sh 'docker-compose push'
      }
    }
 
  }
}
