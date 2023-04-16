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
      stage('Maven Build'){
        steps{
            sh 'mvn clean install'
        }
      }
      stage('Artifact Nexus-upload'){
        steps{
            script{

                nexusArtifactUploader artifacts: 
            [
                [
                    artifactId: 'vprofile', 
                    classifier: '', 
                    file: 'target/vprofile-1.0.1.war', 
                    type: 'war']], 

                        credentialsId: 'nexus-auth', 
                        groupId: 'com.visualpathit', 
                        nexusUrl: '192.168.56.11:8081', 
                        nexusVersion: 'nexus3', 
                        protocol: 'http', 
                        repository: 'realease-vprofileapp', 
                        version: '1.0.1'
            }
        }
      }
    }
}