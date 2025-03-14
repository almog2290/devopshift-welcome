######## Provider ########
terraform {
  required_providers {
    null = {
      source = "hashicorp/null"
      version = "3.2.3"
    }
    time = {
      source = "hashicorp/time"
      version = "0.13.0"
    }
    random = {
      source = "hashicorp/random"
      version = "3.7.1"
    }
  }
}

provider "aws" {
  region = var.region
}

provider "null" {}

provider "time" {}

provider "random" {}