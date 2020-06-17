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
		IMAGE_NAME = "IDM-keycloak-load-testing"
    }
  
    stages {
    	stage('Compiling') {
			steps {
				echo "Compiling and building scala code"
				sh """
					sbt compile
					sbt package
					dir
					cp ${WORKSPACE}/target/scala-2.12/keycloak-load-testing_2.12-1.0-SNAPSHOT.jar ${WORKSPACE}/keycloak-load-testing_2.12-1.0-SNAPSHOT.jar
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
