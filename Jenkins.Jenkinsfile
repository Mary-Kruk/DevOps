
pipeline {
  agent any
  
  stages {
    stage('Clone repository') {
      steps {
        git 'https://github.com/Mary-Kruk/DevOps.git'
      }
    }
    
    stage('Build Docker image') {
      steps {
        script {
          def imageName = "your-image-name"
          def dockerfilePath = "path/to/Dockerfile"
          def dockerBuildArgs = "--build-arg ARG=value"

          docker.withRegistry('https://hub.docker.com', 'docker-credentials-id') {
            def customImage = docker.build(imageName, "-f ${dockerfilePath} ${dockerBuildArgs} .")
            customImage.push('latest')
          }
        }
      }
    }
  }
}
