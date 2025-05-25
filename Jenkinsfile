pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'bodukal/webcal:latest'
        GIT_REPO = 'https://github.com/bodukal/finalproject.git'
        GIT_BRANCH = 'project-1'
    }

    stages {
        stage('Clone') {
            steps {
                git branch: "${GIT_BRANCH}", url: "${GIT_REPO}"
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    dockerImage = docker.build("${DOCKER_IMAGE}")
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                withDockerRegistry([credentialsId: 'dockerhub-creds', url: '']) {
                    script {
                        dockerImage.push()
                    }
                }
            }
        }

        stage('Run Container') {
            steps {
                script {
                    sh 'docker rm -f webcal-container || true'
                    sh 'docker run -d --name webcal-container -p 8082:8080 ${DOCKER_IMAGE}'
                }
            }
        }
    }
}

