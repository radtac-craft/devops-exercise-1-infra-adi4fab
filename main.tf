##########################################
############ Configure VPC ###############
##########################################


resource "aws_vpc" "terraform_vpc" {
  cidr_block = var.cidr_block[0]

  tags = {
    Name = "terraform_vpc"
  }
}


##########################################
####### Creating public Subnet ###########
##########################################

resource "aws_subnet" "public-sg-1" {
  cidr_block = var.cidr_block[1]
  vpc_id     = aws_vpc.terraform_vpc.id

  tags = {
    Name = "public-sg-1"
  }
}


##########################################
############# Creating IGW ###############
##########################################

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.terraform_vpc.id

  tags = {
    Name = "IGW"
  }
}


##########################################
############# Creating SG ################
##########################################

resource "aws_security_group" "SG" {
  name        = "SG"
  vpc_id      = aws_vpc.terraform_vpc.id
  description = "allow inbound and outbound traffic"

  dynamic ingress {
    iterator = port
    for_each = var.ports
    content {
      from_port   = port.value
      protocol    = "tcp"
      to_port     = port.value
      cidr_blocks = ["0.0.0.0/0"]
    }

  }

  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "SG"
  }
}


##########################################
############### AWS RT ###################
##########################################

resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.terraform_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public-rt"
  }
}


##########################################
############# RT ASSOCIATION #############
##########################################

resource "aws_route_table_association" "rt-association" {
  subnet_id      = aws_subnet.public-sg-1.id
  route_table_id = aws_route_table.public-rt.id
}


##########################################
######## Creating JENKINS Instance #######
##########################################

resource "aws_instance" "jenkins-server" {
  ami                         = var.aws_ami
  instance_type               = var.ins_type
  key_name                    = "UKTERRAFORM"
  vpc_security_group_ids      = [aws_security_group.SG.id]
  subnet_id                   = aws_subnet.public-sg-1.id
  associate_public_ip_address = true
  user_data                   = file("./scripts/install-jenkins.sh")
  tags = {
    Name = "jenkins-server"
  }
}


##########################################
## Creating Ansible Controller Instance ##
##########################################

resource "aws_instance" "ansible-CN" {
  ami                         = var.aws_ami
  instance_type               = var.ins_type
  key_name                    = "UKTERRAFORM"
  vpc_security_group_ids      = [aws_security_group.SG.id]
  subnet_id                   = aws_subnet.public-sg-1.id
  associate_public_ip_address = true
  user_data                   = file("./scripts/install-ansiblecn.sh")
  tags = {
    Name = "ansible-Controlnode"
  }
}


##########################################
#### Creating Ansible Managed Instance ###
##########################################

resource "aws_instance" "ansible-MI-1" {
  ami                         = var.aws_ami
  instance_type               = var.ins_type
  key_name                    = "UKTERRAFORM"
  vpc_security_group_ids      = [aws_security_group.SG.id]
  subnet_id                   = aws_subnet.public-sg-1.id
  associate_public_ip_address = true
  user_data                   = file("./scripts/install-ansible-apache.sh")
  tags = {
    Name = "ansible-managednode-apache"
  }
}


##########################################
##### Creating docker host Instance ######
##########################################

resource "aws_instance" "ansible-MI-2" {
  ami                         = var.aws_ami
  instance_type               = var.ins_type
  key_name                    = "UKTERRAFORM"
  vpc_security_group_ids      = [aws_security_group.SG.id]
  subnet_id                   = aws_subnet.public-sg-1.id
  associate_public_ip_address = true
  user_data                   = file("./scripts/install-docker.sh")
  tags = {
    Name = "ansible-managednode-docekrengine"
  }
}


##########################################
### Creating sonartype nexus Instance ####
##########################################

resource "aws_instance" "nexus-server" {
  ami                         = var.aws_ami
  instance_type               = var.ins_type_nexus
  key_name                    = "UKTERRAFORM"
  vpc_security_group_ids      = [aws_security_group.SG.id]
  subnet_id                   = aws_subnet.public-sg-1.id
  associate_public_ip_address = true
  user_data                   = file("./scripts/install-nexus.sh")
  tags = {
    Name = "nexus-server"
  }
}


##########################################################################