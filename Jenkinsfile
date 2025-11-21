pipeline {
    agent any
    
    environment {
        DOCKER_IMAGE = 'yourdockerhubusername/yourapp:latest'
    }

    stages {
        stage('Clone Repository') {
            steps {
                git 'https://github.com/raje33/my-springboot-app.git'
            }
        }
        stage('Build') {
            steps {
                sh 'mvn clean package'
            }
        }
        stage('Docker Build') {
            steps {
                sh 'docker build -t $DOCKER_IMAGE .'
            }
        }
        stage('Docker Push') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh 'echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin'
                    sh 'docker push $DOCKER_IMAGE'
                }
            }
        }
        stage('Deploy') {
            steps {
                // Copy and run commands to EC2 can go here (e.g., with SSH plugin)
                sh 'ssh -i /path/to/your/key.pem ubuntu@your-ec2-ip "docker pull $DOCKER_IMAGE && docker stop yourapp || true && docker rm yourapp || true && docker run -d -p 8080:8080 --name yourapp $DOCKER_IMAGE"'
            }
        }
    }
}

