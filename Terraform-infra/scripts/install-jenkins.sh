#!/bin/bash

## Install java ##

yum install java-1.8.0-openjdk.x86_64 -y


## Download and install jenkins ##

yum update -y
wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
yum install jenkins -y

## Jenkins start and on reboot ##

systemctl start jenkins
systemctl enable jenkins

## Install git ##

yum install git -y

chkconfig jenkins on
