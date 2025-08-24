pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-cred')
        DEV_IMAGE = "kamalesh0610/dev"
        PROD_IMAGE = "kamalesh0610/prod"
    }

    triggers {
        githubPush()
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: env.BRANCH_NAME, url: 'https://github.com/Kamalesh0610/e-commerce-app.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    if (env.BRANCH_NAME == "dev") {
                        sh "docker build -t ${DEV_IMAGE}:${BUILD_NUMBER} ."
                    } else if (env.BRANCH_NAME == "master") {
                        sh "docker build -t ${PROD_IMAGE}:${BUILD_NUMBER} ."
                    }
                }
            }
        }

        stage('Push to DockerHub') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', DOCKERHUB_CREDENTIALS) {
                        if (env.BRANCH_NAME == "dev") {
                            sh "docker push ${DEV_IMAGE}:${BUILD_NUMBER}"
                            sh "docker tag ${DEV_IMAGE}:${BUILD_NUMBER} ${DEV_IMAGE}:latest"
                            sh "docker push ${DEV_IMAGE}:latest"
                        } else if (env.BRANCH_NAME == "master") {
                            sh "docker push ${PROD_IMAGE}:${BUILD_NUMBER}"
                            sh "docker tag ${PROD_IMAGE}:${BUILD_NUMBER} ${PROD_IMAGE}:latest"
                            sh "docker push ${PROD_IMAGE}:latest"
                        }
                    }
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    if (env.BRANCH_NAME == "dev") {
                        echo "Deploying to DEV environment..."
                    } else if (env.BRANCH_NAME == "master") {
                        echo "Deploying to PROD environment..."
                    }
                }
            }
        }
    }
}
