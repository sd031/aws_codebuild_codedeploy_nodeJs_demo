pipeline {
    agent any

    environment {
        BUILD_LOGS = ''  // Initialize the variable here
    }
    stages {
        stage('Source') {
            steps {
                echo 'Hello, Harry Jenkins pipeline demo'
                git branch: 'Master', url: 'https://github.com/yourskaja1216/samplejenkinsproject.git'
            }
        }
        stage('Version') {
            steps {
                echo 'Check the Python version'
                sh 'python3 --version'
                sh 'sudo apt-get install apache2 -y'
                sh 'sudo service apache2 start'
            }
        }
        stage('Build') {
           steps {
                echo 'Build Demo'
                sh 'sudo cp -R * /var/www/html/'
            }
        }

    }
