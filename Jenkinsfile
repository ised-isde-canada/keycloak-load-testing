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
				// sh """
				// 	sbt compile
				// 	sbt package
				// """
				sh '''
                    sbt compile
                    sbt dist
                    cp ${WORKSPACE}/target/universal/idm_keycloak-load-testing_master-1.0-SNAPSHOT.zip ${WORKSPACE}/idm_keycloak-load-testing_master-1.0-SNAPSHOT.zip
                '''
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
