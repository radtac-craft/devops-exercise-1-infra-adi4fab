##########################################
######## Configure Terraform Block #######
##########################################


terraform {
  required_version = "~>0.13.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>3.0"
    }
  }
}

##########################################
######## Configure AWS Provider ##########
##########################################


provider "aws" {
  region  = "us-east-1"
  profile = "terraform_user"
}


##########################################
######## Configure backend s3  ###########
##########################################

terraform {
  backend "s3" {
    bucket = "terraformansibledeplymentintegration"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}
