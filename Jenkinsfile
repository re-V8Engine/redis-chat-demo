library identifier: 'jenkins-shared-library@main', retriever: modernSCM(
        [
                $class: 'GitSCMSource',
                remote: 'https://github.com/re-V8Engine/jenkins-shared-library.git',
                credentials: 'github-credentials'
        ]
)
def version
def dockerTag
pipeline {
    agent any
    stages {
        stage('bump version') {
            steps {
                script {
                    echo 'Bumping version...'
                    sh 'npm version patch'
                    def props = readJSON file: 'package.json'
                    version = props.version
                    dockerTag = "$version-$BUILD_NUMBER"
                }
            }
        }
        stage('buildImages') {
            steps {
		        script {
                    echo "Building frontend and backend images..."
                    dockerBuild("v8engine/redis-chat-demo:backend-$dockerTag", '.')
                    dockerBuild("v8engine/redis-chat-demo:frontend-$dockerTag", './client')
                }
            }
        }
        stage('pushImages') {
            steps {
                script {
                    echo "Pushing images to V8Engine's DockerHub repo..."
                    dockerLogin('dockerhub-credentials')
                    dockerPush("v8engine/redis-chat-demo:backend-$dockerTag")
                    dockerPush("v8engine/redis-chat-demo:frontend-$dockerTag")
                }
            }
        }
    }   
}
