provider "aws" {
  region = var.region
}

variable "region" {
  default = "us-east-1"
}

variable "instance_name" {}


