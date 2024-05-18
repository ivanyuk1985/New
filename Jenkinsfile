pipeline {
    agent any

    environment {
        // Додаємо креденшіали для Docker
    CONTAINER_NAME = 'ivanyuk1985'
    }
    stages {
        stage("docker login") {
            steps {
                echo " ============== docker login =================="
                withCredentials([usernamePassword(credentialsId: '1d416053-b85d-4f24-879a-71dd7ffdb9d1', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                    script {
                        def loginResult = sh(script: "docker login -u $USERNAME -p $PASSWORD", returnStatus: true)
                        if (loginResult != 0) {
                            error "Failed to log in to Docker Hub. Exit code: ${loginResult}"
                        }
                    }
                }
                echo " ============== docker login completed =================="
            }
        }
        stage('Step1') {
            steps {
                echo " ============== docker APACHE =================="
                sh 'docker build -t ivanyuk1985/ivanyukdocker:version${BUILD_NUMBER} .'
                sh 'docker push ivanyuk1985/ivanyukdocker:version${BUILD_NUMBER}'
                
                echo " ============== docker APACHE completed ! =================="
            }
        }
        stage('Зупинка та видалення старого контейнера') {
            steps {
                script {
                    // Спроба зупинити та видалити старий контейнер, якщо він існує
                    sh """
                    if [ \$(docker ps -aq -f name=^${CONTAINER_NAME}\$) ]; then
                        docker stop ${CONTAINER_NAME}
                        docker rm ${CONTAINER_NAME}
                    else
                        echo "Контейнер ${CONTAINER_NAME} не знайдено. Продовжуємо..."
                    fi
                    """
                }
            }
        }

             stage('Чистка старих образів') {
            steps {
                script {
                    // Пушимо зображення на Docker Hub
                    sh 'docker image prune -a --filter "until=5m" --force'

                }
            }
        }
       
        
        
          stage('Запуск Docker контейнера') {
            steps {
                script {
                    // Запускаємо Docker контейнер з новим зображенням
                    sh 'docker run -d -p 8551:80 --name ${CONTAINER_NAME} --health-cmd="curl --fail http://localhost:80 || exit 1" ivanyuk1985/ivanyukdocker:version${BUILD_NUMBER}'

                }
            }
        }
    }
 }

