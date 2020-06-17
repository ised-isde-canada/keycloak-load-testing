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
    	stage('Compiling') {
			steps {
				echo "Compiling and building scala code"
				sh """
					sbt compile
					sbt package
				"""
			}
    	}
		stage('Build images'){
			steps{
				dir("${WORKSPACE}"){
					script{
						builder.buildApp(IMAGE_NAME)
					}
				}
			}
		}
		
    }
}
