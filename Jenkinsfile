pipeline {
    agent any
    environment {
        PATH = "/opt/homebrew/opt/ruby/bin:$PATH"
    }
    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/rohitgithub98/SimpleIosApp.git'
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
                  -retry-tests-on-failure | /opt/homebrew/opt/ruby/bin/xcpretty --test --color
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
        stage('Archive Build') {
            steps {
                sh '''
                mkdir -p build-output
                cp -r ~/Library/Developer/Xcode/DerivedData/**/Build/Products/Debug-iphonesimulator/SimpleIosApp.app build-output/
                '''
                archiveArtifacts artifacts: 'build-output/**', fingerprint: true
            }
        }
    }
}
