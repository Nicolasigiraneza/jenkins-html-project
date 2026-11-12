
pipeline {
    agent any

    environment {
        IMAGE_NAME = 'university-website'
        CONTAINER_NAME = 'university-website-container'
        HOST_PORT = '8081'
    }

    stages {

        stage('Checkout') {
            steps {
                echo 'Downloading project from GitHub'
                checkout scm
            }
        }

        stage('Build') {
            steps {
                echo 'Checking project files'

                bat '''
                    if not exist index.html exit /b 1
                    if not exist Dockerfile exit /b 1
                    if not exist Jenkinsfile exit /b 1
                    echo All project files found successfully
                '''
            }
        }

        stage('Docker Build') {
            steps {
                echo 'Building Docker image'

                bat '''
                    docker build -t %IMAGE_NAME%:latest .
                '''
            }
        }

        stage('Deploy') {
            steps {
                echo 'Deploying website container'

                bat '''
                    docker rm -f %CONTAINER_NAME% 2>NUL
                    docker run -d --name %CONTAINER_NAME% -p %HOST_PORT%:80 %IMAGE_NAME%:latest

                    if errorlevel 1 exit /b 1
                '''
            }
        }

        stage('Verify') {
            steps {
                echo 'Checking website deployment'

                bat '''
                    timeout /t 5 /nobreak >NUL
                    docker ps
                    curl.exe --fail --silent --show-error http://localhost:%HOST_PORT%/ >NUL

                    if errorlevel 1 exit /b 1

                    echo Website is running successfully!
                '''
            }
        }
    }

    post {
        success {
            echo 'SUCCESS: University Website deployed!'
            echo 'Website: http://localhost:8081'
        }

        failure {
            echo 'FAILED: Check Jenkins Console Output.'
        }
    }
}
