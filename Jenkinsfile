pipeline {
    agent any

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/rohitgithub98/SimpleIosApp.git'
            }
        }

        stage('Run Tests') {
            steps {
                sh 'xcodebuild test -project SimpleIosApp.xcodeproj -scheme SimpleIosApp -destination "platform=iOS Simulator,name=iPhone 16"'
            }
        }

        stage('Build Artifact') {
            steps {
                sh 'xcodebuild -project SimpleIosApp.xcodeproj -scheme SimpleIosApp -destination "platform=iOS Simulator,name=iPhone 16" -configuration Release -archivePath build/SimpleIosApp.xcarchive archive'
            }
        }

        stage('Archive Artifacts') {
            steps {
                archiveArtifacts artifacts: 'build/**/*.xcarchive', fingerprint: true
            }
        }
    }
}
