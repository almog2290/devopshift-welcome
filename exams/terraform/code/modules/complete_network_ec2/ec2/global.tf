terraform {
  required_providers {
    time = {
      source = "hashicorp/time"
      version = "0.12.1"
    }
  }
}

provider "aws" {
  region = var.region
}

# aws region
variable "region" {}

# amazon machine image
variable "ami" {}

# instance type
variable "instance_type" {}

# machine name
variable "name" {}

# open ports
variable "ports" {}
