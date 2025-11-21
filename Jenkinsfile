pipeline {
    agent any
    environment {
        DOCKERHUB_CREDS = credentials('dockerhub-creds')
    }
    stages {
        stage('Build Docker Image') {
            steps {
                sh 'docker build -t raje33/my-springboot-app:latest .'
            }
        }
        stage('Docker Login') {
            steps {
                sh 'echo $DOCKERHUB_CREDS_PSW | docker login -u $DOCKERHUB_CREDS_USR --password-stdin'
            }
        }
        stage('Push to Docker Hub') {
            steps {
                sh 'docker push raje33/my-springboot-app:latest'
            }
        }
        stage('Run Container') {
            steps {
                sh 'docker rm -f my-springboot-app || true'
                sh 'docker run -d --name my-springboot-app -p 8080:8080 raje33/my-springboot-app:latest'
            }
        }
    }
}

