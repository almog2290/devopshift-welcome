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

provider "time" {
  # Configuration options
}