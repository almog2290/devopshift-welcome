provider "aws" {
  region = var.region
}
# aws region
variable "region" {
    default = "us-east-1"
    description = "AWS region"
    type        = string
}