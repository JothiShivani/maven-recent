pipeline{
    agent any

    environment{
        scannerHome = tool 'SonarQube Scanner'
        
    }

    stages{
        stage('Checkout'){
            steps{
                // Checkout the code from your version control system
                git 'https://github.com/JothiShivani/maven-recent.git'
            }
        }

        stage('Build Maven Project') {
            steps {
                // Run the Maven build
                bat 'mvn clean install'
            }
        }

        stage('testing mvn'){
            steps{
                bat 'mvn test'
            }
            post {
                always {
                    // Archive test results
                    junit '**/target/surefire-reports/*.xml'
                    // Archive the JAR file produced by the build
                    archiveArtifacts artifacts: '**/target/*.jar', allowEmptyArchive: true
                }
            }
        }
    }
}