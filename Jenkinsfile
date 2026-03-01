pipeline{
    agent any

    environment {
        IMAGE_NAME = 'VASSSIM/WEBAPP'
        IMAGE_TAG = '$(IMAGE_NAME):${GIT_COMMIT}'
    }

    stages{
        stage('Build'){
            steps{
                echo 'Building the application...'
                sh 'npm install'
                sh 'npm run build'
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
                withCredentials([usernamePassword(credentialsId: 'docker-cred', 
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

        stage('Deploy'){
            steps{
                echo 'Deploying the application...'
            }
        }
    }
}
