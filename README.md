# DevOps Exercise #1
####
* Deploy a web application to a cloud provider of your choice. This web application can be something you have written yourself or an open-source project.
* Deploy the web application as a Docker Container.
* Deploy the Docker Container using Kubernetes.
* Any supporting infrastructure should be configured and deployed as code (e.g. Terraform)
* Bonus points for any build and deployment automation employed in the deployment of the web application.
* Bonus points for demonstrating the ability to deploy, destroy and re-deploy the web application and any supporting infrastructure.
* Include all code and artefacts you create to complete this exercise within this repository for review.


FLOW DIAGRAM

![Devops](https://user-images.githubusercontent.com/64772793/121806614-34d86d80-cc6e-11eb-9d48-5f252e82867a.PNG)


* TOOLS INFO:
http://34.233.122.134:8080/ - JENKINS - Username: admin Password: admin

http://52.204.152.255:8081/ - NEXUS - Username: admin Password: admin

* SERVER INFO:
54.88.193.99 username: ansibleadmin password: ansibleansible

Playbook path - /opt/playbooks for deployment in tomcat server and docker deployment

* APPLICATION INFO:
http://3.93.51.86:8080/latest/# - using tomcat server.

http://54.157.210.133:8080/latest/# - using docker containers.

* JENKINS PIPELINE
http://34.233.122.134:8080/ - JENKINS - Username: admin Password: admin

Pipeline 1 - CICD-pipeline - for web application complete CI/CD

Pipeline 2 - Terraform_Infra_provisioning - for infra creation using terraform.
