pipeline {
    agent any
    stages {
        stage("docker login") {
            steps {
                echo " ============== docker login =================="
                withCredentials([usernamePassword(credentialsId: '0bcd4a5d-296e-4be1-8331-ef6e80fa67c6', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
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
                sh 'docker build -t eisgraus/apache:v1 .'
                sh 'docker run -d -p 8446:80 eisgraus/apache:v1'
                sh 'docker push eisgraus/apache:v1'
                echo " ============== docker APACHE completed ! =================="
            }
        }
    }
}
