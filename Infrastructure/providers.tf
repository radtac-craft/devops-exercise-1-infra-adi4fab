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
####### Configure AWS Provider ###########
##########################################


provider "aws" {
  region  = "us-east-1"
  profile = "terraform_user"
}

resource "aws_s3_bucket" "bucket" {
  bucket = "statefilebucketforukterrform"
  acl    = "public-read-write"
}


terraform {
  backend "s3" {
    bucket = "statefilebucketforukterrform"
    key    = "statefile"
    region = "us-east-1"
  }
