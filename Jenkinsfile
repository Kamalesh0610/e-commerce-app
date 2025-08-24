pipeline {
    agent any

    environment {
        IMAGE_NAME = "e-commerce-app"
        DEV_REPO = "kamalesh0610/dev"
        PROD_REPO = "kamalesh0610/prod"
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-creds')
    }

    triggers {
        githubPush() // auto-trigger on push
    }

    stages {
        stage('Checkout Code') {
            steps {
                git branch: "${env.BRANCH_NAME}", url: 'https://github.com/Kamalesh0610/e-commerce-app.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    VERSION = env.BUILD_NUMBER

                    if (env.BRANCH_NAME == "dev") {
                        REPO = DEV_REPO
                    } else if (env.BRANCH_NAME == "main") {
                        REPO = PROD_REPO
                    } else {
                        error "Unsupported branch: ${env.BRANCH_NAME}"
                    }

                    sh """
                      docker build -t ${IMAGE_NAME}:${VERSION} .
                      docker tag ${IMAGE_NAME}:${VERSION} ${REPO}:${VERSION}
                      docker tag ${IMAGE_NAME}:${VERSION} ${REPO}:latest
                    """
                }
            }
        }

        stage('Push to DockerHub') {
            steps {
                withDockerRegistry([credentialsId: 'dockerhub-creds', url: 'https://index.docker.io/v1/']) {
                    sh """
                      docker push ${REPO}:${VERSION}
                      docker push ${REPO}:latest
                    """
                }
            }
        }

        stage('Deploy to AWS') {
            when { branch 'main' } // deploy only from master/main
            steps {
                sshagent(['aws-ec2-key']) {
                    sh '''
                      ssh -o StrictHostKeyChecking=no ubuntu@<EC2_PUBLIC_IP> "
                        docker pull ${REPO}:latest &&
                        docker stop ecommerce || true &&
                        docker rm ecommerce || true &&
                        docker run -d --name ecommerce -p 80:80 ${REPO}:latest
                      "
                    '''
                }
            }
        }
    }
}
