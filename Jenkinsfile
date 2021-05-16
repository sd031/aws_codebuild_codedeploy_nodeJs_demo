pipeline {
  agent any
    
  tools {nodejs "node"} 
    
  stages {
        
    stage('Git') {
      steps {
        git 'https://github.com/sd031/aws_codebuild_codedeploy_nodeJs_demo.git'
      }
    }
     
    stage('Build') {
      steps {
        sh 'npm install'
        // sh '<<Build Command>>' run any commands as needed
      }
    }  
            
    // stage('Test') {
    //   steps {
    //     sh 'node test'
    //   }
    // }
  }
}