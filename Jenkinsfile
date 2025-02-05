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
                
                # Stop all simulators & start fresh
                xcrun simctl shutdown all
                xcrun simctl erase all
                
                # Get Simulator UDID
                SIMULATOR_UDID=$(xcrun simctl list devices available | grep "iPhone 16" | head -n 1 | awk -F '[()]' '{print $2}')
                
                if [ -z "$SIMULATOR_UDID" ]; then
                    echo "❌ No available iPhone 16 simulator found!"
                    exit 1
                fi
                
                echo "✅ Using Simulator: $SIMULATOR_UDID"
                
                # Boot up the simulator
                xcrun simctl boot "$SIMULATOR_UDID"
                
                # Ensure simulator is running
                open -a Simulator

                # Wait for simulator to be fully ready
                sleep 10

                xcodebuild test \
                  -project SimpleIosApp.xcodeproj \
                  -scheme SimpleIosApp \
                  -destination "platform=iOS Simulator,id=$SIMULATOR_UDID" \
                  -disable-concurrent-destination-testing \
                  -enableCodeCoverage YES \
                  -retry-tests-on-failure | /opt/homebrew/opt/ruby/bin/xcpretty --test --color
                '''
            }
        }
        stage('Build Archive') {
            steps {
                sh '''
                export PATH="/opt/homebrew/opt/ruby/bin:$PATH"

                # Archive the app
                xcodebuild archive \
                  -project SimpleIosApp.xcodeproj \
                  -scheme SimpleIosApp \
                  -archivePath build-output/SimpleIosApp.xcarchive \
                  -sdk iphoneos \
                  -allowProvisioningUpdates
                '''
            }
        }
        stage('Export IPA') {
            steps {
                sh '''
                export PATH="/opt/homebrew/opt/ruby/bin:$PATH"

                # Create ExportOptions.plist file
                cat <<EOF > ExportOptions.plist
                {
                  "method": "development",
                  "teamID": "YOUR_TEAM_ID",
                  "compileBitcode": false,
                  "destination": "export",
                  "signingStyle": "automatic",
                  "stripSwiftSymbols": true,
                  "thinning": "<none>"
                }
                EOF

                # Export IPA
                xcodebuild -exportArchive \
                  -archivePath build-output/SimpleIosApp.xcarchive \
                  -exportOptionsPlist ExportOptions.plist \
                  -exportPath build-output/
                '''
            }
        }
        stage('Archive Build') {
            steps {
                sh '''
                mkdir -p build-output
                '''
                archiveArtifacts artifacts: 'build-output/SimpleIosApp.ipa', fingerprint: true
            }
        }
    }
}

