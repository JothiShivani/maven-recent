pipeline{
    agent any

    environment{
        scannerHome = tool 'SonarQube Scanner'
        SONAR_TOKEN = '19cc89fddb20a0c36268c322fc9f44c24a5a295d'


        
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

        stage('Run SonarCloud') {
            steps {
                withSonarQubeEnv('SonarQube Scanner') {
                bat "${scannerHome}/bin/sonar-scanner \
                -Dsonar.projectKey=JothiShivani_maven-recent \
                -Dsonar.organization=jothishivani \
                -Dsonar.host.url=https://sonarcloud.io \
                -Dsonar.login=${SONAR_TOKEN} \
                -Dsonar.exclusion=**/*.java \
                -Dsonar.java.binaries=target/classes"

                }
            }
        }
    }
}