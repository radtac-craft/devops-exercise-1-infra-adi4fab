pipeline{
    //Directives
    agent any
    tools {
        maven 'maven'
    }

    environment {
        ArtifactId = readMavenPom().getArtifactId()
        Version = readMavenPom().getVersion()
        Name = readMavenPom().getName()
        GroupId = readMavenPom().getGroupId()
    }

    stages {

        stage ('Check: Env variables'){
                      steps {
                          echo "Artifact ID is '${ArtifactId}'"
                          echo "Version is '${Version}'"
                          echo "GroupID is '${GroupId}'"
                          echo "Name is '${Name}'"
                      }
                }

        stage ('Build: Package'){
            steps {
                sh 'mvn clean install package'
            }
        }

        stage ('Publish: Nexus'){
             steps {
                 script {

                 def NexusRepo = Version.endsWith("SNAPSHOT") ? "adityasdevopslab-SNAPSHOT" : "adityasdevopslab-RELEASE"

                 nexusArtifactUploader artifacts:
                 [[artifactId: "${ArtifactId}",
                 classifier: '',
                 file: "target/${ArtifactId}-${Version}.war",
                 type: 'war']],
                 credentialsId: 'nexus-cred',
                 groupId: "${GroupId}",
                 nexusUrl: '52.204.152.255:8081',
                 nexusVersion: 'nexus3',
                 protocol: 'http',
                 repository: "${NexusRepo}",
                 version: "${Version}"
              }
             }
        }


        stage ('Deploy: Tomcat server'){
               steps {
                   echo ' Deploying......'
                   sshPublisher(publishers:
                   [sshPublisherDesc(
                   configName: 'Ansible_Controller',
                   transfers: [
                        sshTransfer(
                            cleanRemote: false,
                            execCommand: 'ansible-playbook /opt/playbooks/downloadanddeploy.yaml -i /opt/playbooks/hosts',
                            execTimeout: 120000
                        )

                   ],
                   usePromotionTimestamp: false,
                   useWorkspaceInPromotion: false,
                   verbose: false)
                   ])
              }
        }

        stage ('Deploy: Tomcat container'){
               steps {
                   echo ' Deploying......'
                   sshPublisher(publishers:
                   [sshPublisherDesc(
                   configName: 'Ansible_Controller',
                   transfers: [
                        sshTransfer(
                            cleanRemote: false,
                            execCommand: 'ansible-playbook /opt/playbooks/downloadanddeploy_docker.yaml -i /opt/playbooks/hosts',
                            execTimeout: 120000
                        )

                   ],
                   usePromotionTimestamp: false,
                   useWorkspaceInPromotion: false,
                   verbose: false)
                   ])
               }
        }
    }
}