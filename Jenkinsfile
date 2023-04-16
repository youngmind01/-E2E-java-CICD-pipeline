pipeline{

    agent any

    stages{
        stage('Git checkout'){

            steps{
                git branch:'master', url:'https://github.com/youngmind01/E2E-java-CICD-pipeline.git'
            }
        }
        stage('Unit test'){
            steps{
                sh 'mvn test'
            }
        }
        stage('Integration test'){
            steps{
                sh 'mvn verify -DskipUnitTests'
            }
        }
        stage('checkstyle analysis'){
            steps{
                sh 'mvn checkstyle:checkstyle'
            }
        }
        stage('Sonarqube Analysis'){
            steps{
                script{
                    withSonarQubeEnv(credentialsId: 'sonar-api-key') {
                    sh 'mvn clean package sonar:sonar'
                }
            }
        }
      }
    }
}