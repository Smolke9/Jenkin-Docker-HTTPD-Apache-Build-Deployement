pipeline {
  agent any
  stages {
    stage('Clone') {
      steps {
        git 'https://github.com/Smolke9/Jenkin-Docker-HTTPD-Apache-Build-Deployement.git'
      }
    }
    stage('Build Docker Image') {
      steps {
        sh 'docker build -t apacheapp .'
      }
    }
    stage('Run Docker Container') {
      steps {
        sh 'docker run -d -p 80:80 apacheapp'
      }
    }
  }
}

