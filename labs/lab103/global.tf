provider "aws" {
 region = var.region
}

variable "region" {
 default = "us-east-1"
}

# variable "ami" {
#  default = "ami-04b4f1a9cf54c11d0"
# }

variable "vm_name" {
 default = "vm-almog-devops"
}

variable "admin_username" {
 default = "admin-user"
}

variable "admin_password" {
 default = "Password123!"
}

variable "vm_size" {
 default = "t2.micro"
}

# bring specific ami from yaniv repo
data "aws_ami" "ami_version" {
  filter {
    name   = "name"
    values = ["terraform-workshop-image-do-not-delete"]
  }
}
