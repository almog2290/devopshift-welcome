provider "aws" {
  region = var.region
}

# aws region
variable "region" {
  default = "us-east-1"
  description = "AWS region"
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

variable "associate_public_ip" {
  default = false
  description = "Whether to associate a public IP address with the instance"
}


variable "vpc_id" {
  default = ""
  description = "VPC ID"
}

variable "custom_subnet_id" {
  default = ""
  description = "Custom subnet ID"
}

variable "admin_username" {
  default = "admin-user"
}

variable "admin_password" {
  default = "Password123!"
}



