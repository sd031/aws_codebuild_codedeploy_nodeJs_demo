pipeline {
    agent any

    environment {
        BUILD_LOGS = ''  // Initialize the variable here
    }
    stages {
        stage('Source') {
            steps {
                echo 'Hello, Harry Jenkins pipeline demo'
                git branch: 'Master', url: 'https://github.com/Mynotesoracledba/SampleJenkinsproject.git'
                sh 'cat web_scrapper.py'
            }
        }
        stage('Version') {
            steps {
                echo 'Check the Python version'
                sh 'python3 --version'
            }
        }
        stage('Build') {
           steps {
                echo 'Build Demo'
                sh 'pip install -r requirement.txt'
            }
        }
    
         stage('Deploy') {
           steps {
                echo 'Depoly Demo'
                sh 'python3 web_scrapper.py'
            }
        }

    }
