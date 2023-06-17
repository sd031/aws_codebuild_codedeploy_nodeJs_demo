pipeline {
    agent { label 'ec2Agent' }
    tools {nodejs "node16" }
    environment {
        NODE_ENV='production'
    }
    
  
    stages {
       
        stage('source') {
            steps {
               git credentialsId: '296b18ab-4260-44bd-ba13-0c8b6f6208a5', url: 'https://github.com/sd031/aws_codebuild_codedeploy_nodeJs_demo'
               sh 'cat index.js'
            }
            
        }
        
         stage('build') {
             environment{
                 NODE_ENV='StagingGitTest'
             }
             
            
            steps {
             echo NODE_ENV
            //  withCredentials([string(credentialsId: 'e8f8ff88-49e0-433a-928d-36a518cd30d6', variable: 'secver')]) {
            //     // some block
            //     echo secver
            // }
            sh 'npm install'
            }
            
        }
        
        //  stage('saveArtifact') {
        //     steps {
        //       archiveArtifacts artifacts: '**', followSymlinks: false
        //     }
            
        // }
        
        
        
    }

    post {  
         always {  
             echo 'This will always run'  
         }  
         success {  
             echo 'This will run only if successful'  
         }  
         failure {  
             mail bcc: '', body: "<b>Example</b><br>Project: ${env.JOB_NAME} <br>Build Number: ${env.BUILD_NUMBER} <br> URL de build: ${env.BUILD_URL}", cc: '', charset: 'UTF-8', from: '', mimeType: 'text/html', replyTo: '', subject: "ERROR CI: Project name -> ${env.JOB_NAME}", to: "foo@foomail.com";  
         }  
         unstable {  
             echo 'This will run only if the run was marked as unstable'  
         }   
     }
}
