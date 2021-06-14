variable "cidr_block" {
  type        = list(string)
  description = "specify the CIDR block"
  default     = ["172.20.0.0/16", "172.20.10.0/24"]
}

variable "ports" {
  type        = list(number)
  description = "SG ingress ports"
  default     = ["22", "80", "443", "8080", "8081","9000"]
}

variable "aws_ami" {
  type        = string
  description = "AMI id for amz linux 2"
  default     = "ami-0aeeebd8d2ab47354"
}

variable "ins_type" {
  type        = string
  description = "instance type of the instance"
  default     = "t2.micro"
}

variable "ins_type_nexus" {
  type        = string
  description = "instance type of the instance"
  default     = "t2.medium"
}

