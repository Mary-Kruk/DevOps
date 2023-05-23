pipeline {
    agent any
    
    stages {
        stage('Checkout') {
            steps {
                // Клонування репозиторію з Git
                git 'https://github.com/Mary-Kruk/DevOps.git'
            }
        }
        
        stage('Build Docker Image') {
            steps {
                // Збірка Docker образу з Dockerfile
                script {
                    def dockerImage = docker.build('your-image-name', '.')
                    dockerImage.push() // Додатково можна використовувати push() для публікації образу
                }
            }
        }
    }
    
    post {
        always {
            script {
                // Завершення контейнерів та мережі
                docker.image('your-image-name').withRun('-d') { container ->
                    // Закоментуйте цей рядок, якщо вам не потрібно виконувати додаткові дії після запуску контейнера
                    sh 'docker exec -it ${container.id} command' // Замініть 'command' на команду, яку ви бажаєте виконати в контейнері
                }
                docker.image('your-image-name').stop() // Зупинка контейнерів перед видаленням
                docker.image('your-image-name').remove(force: true) // Видалення Docker образу
                sh 'docker network prune -f' // Видалення мережі Docker (якщо необхідно)
            }
        }
    }
}
