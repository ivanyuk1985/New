pipeline {
    agent any
    stages {
        stage("docker login") {
            steps {
                echo " ============== docker login =================="
                withCredentials([usernamePassword(credentialsId: 'd8fd0796-f38d-48dc-b941-4a520d23dddd', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
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
