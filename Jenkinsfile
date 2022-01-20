pipeline {
    agent any
    tools {nodejs "node17"}
    environment {
        NODE_ENV='production'
    }

    stages {
        stage('source') {
            steps {
                git 'https://github.com/demask/aws_codebuild_codedeploy_nodeJs_demo.git'
            }
        }
        
        stage('build') {
            steps {
                echo NODE_ENV
                withCredentials([string(credentialsId: '22b3c2c9-bcab-4d44-af8b-e02817da1f96', variable: 'secvar')]) {
                    // some block
                    echo secvar
                }
                sh 'npm install'
            }
        }
        
         stage('saveArtifact') {
             environment{
                 NODE_ENV='artifact'
             }
            steps {
                echo NODE_ENV
                archiveArtifacts artifacts: '**', followSymlinks: false
            }
        }
    }
}
