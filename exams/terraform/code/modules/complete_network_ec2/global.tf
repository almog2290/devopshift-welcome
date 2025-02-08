provider "aws" {
  region = var.region
}

# aws region
variable "region" {
  default = "us-east-1"
  description = "AWS region"
}

# network instance name
variable "network_instance_name" {
  default = "devops"
  description = "Network instance name"
}

# amazon machine image
variable "ami" {
  default = "ami-0ff8a91507f77f867" # Amazon Linux 2 AMI in us-east-1
  description = "AMI ISO number"
}

# instance type
variable "instance_type" {
  default = "t2.micro"
  description = "Instance type"
}

# machine name
variable "vm_name" {
  default = "devops"
  description = "Machine name"
}

# open ports
variable "ports" {
  default = []
  type = list(number)
  description = "Open ports of VM (ingress)"
}


