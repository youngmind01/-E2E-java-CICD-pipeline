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

                    def readPomVersion = readMavenPom file: 'pom.xml' 
                    def nexusRepo = readPomVersion.version.endsWith("SNAPSHOT") ? "vprofile-app-snapshot" : "realease-vprofileapp"
                nexusArtifactUploader artifacts: 
            [
                [
                    artifactId: 'vprofile', 
                    classifier: '', 
                    file: 'target/vprofile-1.0.1-SNAPSHOT.war', 
                    type: 'war']], 

                        credentialsId: 'nexus-auth', 
                        groupId: 'com.visualpathit', 
                        nexusUrl: '192.168.56.11:8081', 
                        nexusVersion: 'nexus3', 
                        protocol: 'http', 
                        repository: nexusRepo, 
                        version: "${readPomVersion.version}"
            }
        }
      }
      stage('Docker build'){
        steps{
            script{

                    sh 'docker build -t $JOB_NAME:v1.$BUILD_ID .'
                    sh 'docker image tag $JOB_NAME:v1.$BUILD_ID ppraise01/$JOB_NAME:v1.$BUILD_ID'
                    sh 'docker image tag $JOB_NAME:v1.$BUILD_ID ppraise01/$JOB_NAME:latest'
            }
        }
      }
    }
}