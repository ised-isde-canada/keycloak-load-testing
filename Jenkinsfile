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
				echo "Building image from dockerfile"
				dir("${WORKSPACE}")
				echo "${WORKSPACE}"
				script{
					build.buildApp("idm-keycloak-load-testing")
				}
			}
    	}
		
    }
}
