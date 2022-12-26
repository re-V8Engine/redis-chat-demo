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
    tools {
        nodejs 'nodejs-19'
    }
    stages {
        stage('bump version') {
            steps {
                script {
                    echo 'Bumping version...'
                    sh 'npm version patch --git-tag-version false --allow-same-version'
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
        stage('commit version update') {
            steps {
                script {
                    echo 'Testing jenkins commit ignore...'
                    echo 'Push version update to GitHub...'
                    gitSetRemote('github-token', 'github.com/re-V8Engine/redis-chat-demo.git')
                    gitAddAll()
                    gitCommit "CI: version bump $version"
                    gitPush 'main'
                }
            }
        }
    }   
}
