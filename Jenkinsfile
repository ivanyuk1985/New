pipeline {
    agent any
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
                sh 'docker build -t ivanyuk1985/ivanyukdocker:v2 .'
                sh 'docker run -d -p 8551:80 ivanyuk1985/ivanyukdocker:v2'
                sh 'docker push ivanyuk1985/ivanyukdocker:v2'
                echo " ============== docker APACHE completed ! =================="
            }
        }
    }
}
