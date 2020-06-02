@Library('ised-cicd-lib') _

pipeline {
  	agent {
        label 'scala-sbt-2.12-1.2'
    }
	
    options {
        disableConcurrentBuilds()
    }
  
   	environment {
		// GLobal Vars
		IMAGE_NAME = "idm-keycloak-load-testing"
    }
  
    stages {
    	stage('build') {
			steps {
				echo "Compiling project"
				// sh '''
				// 	sbt compile
				// '''
			}
    	}
		stage("Testing"){
			steps{
				echo "Running keycloak load test"
				// sh '''
				// 	sbt gatling:test
				// '''
			}
		}
    }
}
