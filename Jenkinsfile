pipeline {
    agent any 
    tools {
        maven 'maven'
    }
    
    stages {
        stage ('build') {
            steps {
                sh 'mvn clean install package'
            }
        }
        
        stage ('test') {
            steps {
                sh 'testing .....'
            }
        }
        
        stage ('publish to nexus') {
            steps {
                nexusArtifactUploader artifacts: [[artifactId: 'DevOpsLab', classifier: '', file: 'target/DevOpsLab-0.0.8.war', type: 'war']], credentialsId: 'nexus', groupId: 'com.ukdevops', nexusUrl: '172.20.10.166:8081', nexusVersion: 'nexus3', protocol: 'http', repository: 'devopslab-snapshot', version: '0.0.8'
            }
        }
    }
}
