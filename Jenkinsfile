pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'bodukal/webcal:latest'
        GIT_REPO = 'https://github.com/bodukal/finalproject.git'
        GIT_BRANCH = 'project-3'
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

        stage('Deploy to Kubernetes') {
            steps {
                script {
                    sh '''
                        kubectl set image deployment/webcal-deployment webcal-container=${DOCKER_IMAGE} --record || \
                        kubectl apply -f k8s/webcal-deployment.yaml
                        
                        kubectl rollout status deployment/webcal-deployment
                    '''
                }
            }
        }
    }

    post {
        failure {
            echo 'Pipeline failed!'
        }
        success {
            echo 'Pipeline executed successfully.'
        }
    }
}

