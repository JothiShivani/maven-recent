pipeline{
    agent any

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
    }
}