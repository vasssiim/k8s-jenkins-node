pipeline{
    agent any

    environment {
        IMAGE_NAME = 'vasssim/webapp'
        IMAGE_TAG = "${IMAGE_NAME}:${GIT_COMMIT}"
        AWS_ACCESS_KEY_ID = credentials('aws-access-key-id')
        AWS_SECRET_ACCESS_KEY = credentials('aws-secret-access-key')
    }

    stages{
        stage('Build'){
            steps{
                echo 'Building the application...'
                sh 'npm install'
            }
        }
        stage('Test'){
            steps{
                echo 'Running tests...'
                sh 'npm test'
            }
        }
        stage('login to docker hub'){
            steps{
                echo 'Logging in to Docker Hub...'
                withCredentials([usernamePassword(credentialsId: 'docker-creds', 
                usernameVariable: 'USERNAME', 
                passwordVariable: 'PASSWORD')]) {
                    sh 'echo $PASSWORD | docker login -u $USERNAME --password-stdin'
                    echo 'Logged in to Docker Hub successfully.'
                }
            }
        }

        stage('Build Docker Image'){
            steps{
                echo 'Building Docker image...'
                sh "docker build -t ${IMAGE_TAG} ."
                echo 'Docker image built successfully.'
            }
        }

        stage('Push Docker Image'){
            steps{
                echo 'Pushing Docker image to registry...'
                sh "docker push ${IMAGE_TAG}"
                echo 'Docker image pushed successfully.'
            }
        }

        stage('Deploy to Kubernetes'){
            steps{
                echo 'Deploying to Kubernetes...'
                withKubeConfig([credentialsId: 'kubeconfig-creds']) {
                    sh "kubectl set image deployment/k8s-webapp k8s-webapp=${IMAGE_TAG} -n webapp"
                    echo 'Deployment updated successfully.'
                }
            }
        }

        stage('Deploy'){
            steps{
                echo 'Deploying the application...'
            }
        }
    }
}
