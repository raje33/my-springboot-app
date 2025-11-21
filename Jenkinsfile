pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "raje33/my-springboot-app:latest"
    }

    stages {

        stage('Clone Repository') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/raje33/my-springboot-app.git',
                    credentialsId: 'github-credentials'
            }
        }

        stage('Build') {
            steps {
                sh 'mvn clean package -DskipTests'
            }
        }

        stage('Docker Build') {
            steps {
                sh 'docker build -t $DOCKER_IMAGE .'
            }
        }

        stage('Docker Push') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials',
                                                 usernameVariable: 'DOCKER_USER',
                                                 passwordVariable: 'DOCKER_PASS')]) {
                    sh 'echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin'
                    sh 'docker push $DOCKER_IMAGE'
                }
            }
        }

        stage('Deploy') {
            steps {
                sh '''
                ssh -o StrictHostKeyChecking=no -i /path/to/key.pem ubuntu@<EC2-IP> "
                    docker pull $DOCKER_IMAGE &&
                    docker stop myapp || true &&
                    docker rm myapp || true &&
                    docker run -d -p 8080:8080 --name myapp $DOCKER_IMAGE
                "
                '''
            }
        }
    }
}

