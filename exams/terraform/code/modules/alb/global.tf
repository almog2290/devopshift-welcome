provider "aws" {
  region = var.region
}

variable "alb_name" {
    description = "Prefix name of the Application Load Balancer"
    type        = string
}

# aws region
variable "region" {
    default = "us-east-1"
    description = "AWS region"
    type        = string
}

# VPC ID
variable "vpc_id" {
    description = "VPC ID"
    type        = string
}

# load balancer subnets
variable "subnets" {
    description = "List of subnets"
    type        = list(string)
}

# list of EC2 instances assigned to the target group
variable "vm_instances" {
    description = "List of EC2 instances"
}

# AMI ID for the EC2 instances
variable "ami_id" {
  description = "AMI ID for the EC2 instances"
  type        = string
}

# instance type for the EC2 instances
variable "instance_type" {
  description = "Instance type for the EC2 instances"
  type        = string
}

# user data for the EC2 instances
variable "admin_username" {
  default = "admin-user"
}

variable "admin_password" {
  default = "Password123!"
}