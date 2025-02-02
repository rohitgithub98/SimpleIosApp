pipeline {
    agent any
    environment {
        PATH = "/opt/homebrew/opt/ruby/bin:$PATH"
    }
    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/rohitgithub98/SimpleIosApp.git'
            }
        }
        stage('Run Tests') {
            steps {
                sh '''
                export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
                xcodebuild test \
                  -project SimpleIosApp.xcodeproj \
                  -scheme SimpleIosApp \
                  -destination "platform=iOS Simulator,name=iPhone 16" \
                  -disable-concurrent-destination-testing \
                  -enableCodeCoverage YES \
                  -retry-tests-on-failure | /opt/homebrew/opt/ruby/bin/xcpretty
                '''
            }
        }
        stage('Build Artifact') {
            steps {
                sh '''
                export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
                xcodebuild build \
                  -project SimpleIosApp.xcodeproj \
                  -scheme SimpleIosApp \
                  -destination "platform=iOS Simulator,name=iPhone 16"
                '''
            }
        }
    }
}
