pipeline {
    agent any
    stages {
        stage('buildImages') {
            steps {
                echo "Building frontend and backend images..."
                sh "docker build -t v8engine/redis-chat-demo:backend-1.0 ."
                sh "docker build -t v8engine/redis-chat-demo:frontend-1.0 ./client"
            }
        }
        stage('pushImages') {
            steps {
                script {
                    echo "Pushing images to V8Engine's DockerHub repo..."
                    withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials', passwordVariable: 'PASS', usernameVariable: 'USER')]) {
                        sh "echo $PASS | docker login -u $USER --password-stdin"
                        sh "docker push v8engine/redis-chat-demo:backend-1.0"
                        sh "docker push v8engine/redis-chat-demo:frontend-1.0"
                    }
                }
            }
        }
    }   
}
