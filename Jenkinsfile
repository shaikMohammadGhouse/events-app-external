// prerequisites: a nodejs app must be deployed inside a kubernetes cluster
// TODO: look for all instances of [] and replace all instances of 
//       the 'variables' with actual values 
// variables:
//      https://github.com/shaikMohammadGhouse/events-app-external.git
//      dtc082021-429
//      cluster-3 
//      us-central1-c
//      the following values can be found in the yaml:
//      demo-ui
//      demo-ui (in the template/spec section of the deployment)

pipeline {
    agent any 
    stages {
        stage('Stage 1: GIT Checkout') {
            steps {
                echo 'Retrieving source from github' 
                git branch: 'master',
                    url: 'https://github.com/shaikMohammadGhouse/events-app-external.git'
                echo 'Did we get the source?' 
                sh 'ls -a'
            }
        }
        stage('Stage 2: Echoing contents') {
            steps {
                echo 'workspace and versions' 
                sh 'echo $WORKSPACE'
                sh 'gcloud version'
                sh 'nodejs -v'
                sh 'npm -v'
        
            }
        }        
         stage('Stage 3: Runnning NPM install') {
             echo 'running npm instal--------'
            environment {
                PORT = 8081
            }
            steps {
                echo 'install dependencies' 
                sh 'npm install'
                echo 'Run tests'
                sh 'npm test'
        
            }
        }        
         stage('Stage 4: Pushing Docker image to GCR') {
            steps {
                echo "build id = ${env.BUILD_ID}"
                echo 'Tests passed on to build Docker container'
                sh "gcloud builds submit -t gcr.io/dtc082021-429/external:v2.${env.BUILD_ID} ."
            }
        }        
         stage('Stage 5: running Kuberenete for docker images') {
            steps {
                echo 'Get cluster credentials'
                sh 'gcloud container clusters get-credentials cluster-3 --zone us-central1-c --project dtc082021-429'
                echo 'Update the image'
                echo "gcr.io/dtc082021-429/external:2.${env.BUILD_ID}"
                sh "kubectl set image deployment/demo-ui demo-ui=gcr.io/dtc082021-429/external:v2.${env.BUILD_ID} --record"
            }
        }        
               

        
    }
}
