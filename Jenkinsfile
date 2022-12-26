library identifier: 'jenkins-shared-library@main', retriever: modernSCM(
        [
                $class: 'GitSCMSource',
                remote: 'https://github.com/re-V8Engine/jenkins-shared-library.git',
                credentials: 'github-credentials'
        ]
)

pipeline {
    agent any
    stages {
        stage('buildImages') {
            steps {
		echo "Testing build trigger...."
                echo "Building frontend and backend images..."
                dockerBuild('v8engine/redis-chat-demo:backend-1.0', '.')
                dockerBuild('v8engine/redis-chat-demo:frontend-1.0', './client')
            }
        }
        stage('pushImages') {
            steps {
                script {
                    echo "Pushing images to V8Engine's DockerHub repo..."
                    dockerLogin('dockerhub-credentials')
                    dockerPush('v8engine/redis-chat-demo:backend-1.0')
                    dockerPush('v8engine/redis-chat-demo:frontend-1.0')
                }
            }
        }
    }   
}
