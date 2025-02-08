provider "aws" {
  region = var.region
}

# aws region
variable "region" {
  default = "us-east-1"
  description = "AWS region"
}

# network instance name
variable "instance_name" {
  default = "devops"
  description = "Network instance name"
}

variable "cidr_block" {
  default = "10.0.0.0/16"
  description = "CIDR block for the VPC"
}

variable "subnet_count" {
  default = 2
  description = "Number of subnets to create"
}

variable "az_list" {
 default = ["us-east-1a","us-east-1b","us-east-1c","us-east-1d" , "us-east-1e" , "us-east-1f"]
}

