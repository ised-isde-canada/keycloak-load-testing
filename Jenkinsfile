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
				sh '''
					sbt compile
					sbt dist
					cp ${WORKSPACE}/keycloak-load-testing/target/universal/keycloak-load-testing-1.0-SNAPSHOT.zip ${WORKSPACE}/keycloak-load-testing/idm-keycloak-load-testing-1.0-SNAPSHOT.zip 
				'''
			}
    	}
		stage('Build images'){
			steps{
				dir("${WORKSPACE}/keycloak-load-testing"){
					script{
						builder.buildApp(IMAGE_NAME)
					}
				}
			}
		}
		
    }
}
