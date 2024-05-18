pipeline {
    agent any

    environment {
        // Додаємо креденшіали для Docker
        DOCKER_CREDENTIALS_ID = 'dockerHub'
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
        stage('Delete Images Older than 20 Minutes') {
            steps {
                script {
                    // Змініть на свій репозиторій
                    def repo = "ivanyuk1985/ivanyukdocker"
                    def images = sh(script: "curl -s https://hub.docker.com/v2/repositories/${repo}/tags/?page_size=100", returnStdout: true)
                    def imageList = readJSON text: images
                    def now = new Date().getTime()
                    def threshold = 20 * 60 * 1000 // 20 хвилин в мілісекундах

                    imageList.results.each { image ->
                        def created = image.last_updated
                        def createdTime = Date.parse("yyyy-MM-dd'T'HH:mm:ss.SSSSSS'Z'", created).getTime()
                        if ((now - createdTime) > threshold) {
                            def tag = image.name
                            echo "Deleting image: ${repo}:${tag}, created at: ${created}"
                            sh "docker rmi ${repo}:${tag} || true"
                            sh "curl -s -X DELETE  https://hub.docker.com/v2/repositories/${repo}/tags/${tag}/"
                        }
                    }
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

