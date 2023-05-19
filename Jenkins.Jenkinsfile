pipeline {
  agent any
  
  stages {
    stage('Clone repository') {
      steps {
           git branch: 'main', url: 'https://github.com/Mary-Kruk/DevOps.git'

      }
    }
    
    stage('Build Docker image') {
      steps {
        script {
          def imageName = "your-image-name"
          def dockerfilePath = "Dockerfile"
          def dockerBuildArgs = "--build-arg ARG=value"

          docker.withRegistry('https://index.docker.io/v1/', 'Docker-Mary') {
            //sh "docker build -t your-image-name -f main/Dockerfile ."

            def customImage = sh "docker build -t your-image-name -f ./Dockerfile ."



            customImage.push('latest')
          }
        }
      }
    }
  }
}
