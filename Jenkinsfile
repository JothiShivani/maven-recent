pipeline{
    agent any

    environment{
        scannerHome = tool 'SonarQube Scanner'
        SONAR_TOKEN = '19cc89fddb20a0c36268c322fc9f44c24a5a295d'
        DOCKER_IMAGE = "maven-recent"
        DOCKER_HUB_CREDENTIALS = 'docker-hub-credentials' 
        AWS_ACCESS_KEY_ID     = credentials('AWS Access Key ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS Secret Access Key')
        



        
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
        
        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image using the Dockerfile
                    bat 'docker build -t %DOCKER_IMAGE% .'
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    // Push the Docker image to Docker Hub
                    docker.withRegistry('https://index.docker.io/v1/', DOCKER_HUB_CREDENTIALS) {
                        bat 'docker tag %DOCKER_IMAGE% jothishivani/%DOCKER_IMAGE%'
                        bat 'docker push jothishivani/%DOCKER_IMAGE%'
                    }
                }
            }
        }

        // stage('Terraform'){
        //     steps{
        //         bat 'C:\\Users\\mathanj\\terraform\\terraform init'
        //         bat 'C:\\Users\\mathanj\\terraform\\terraform plan'
        //         bat 'C:\\Users\\mathanj\\terraform\\terraform apply -auto-approve'

        //     }
        // }

        
    }
}