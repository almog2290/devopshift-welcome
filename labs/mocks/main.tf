provider "aws" {
  region = var.region
}

variable "region" {
  default = "us-east-1"
}

data "aws_instance" "yanim-vm" {
  instance_id = "i-09df7e0ed385f871b"

  filter {
    name   = "tag:Name"
    values = ["yaniv-vm"]
  }
}

output "vm_yanin_info" {
  value      = data.aws_instance.yanim-vm.public_ip
  description = "yaniv-vm public ip"
}
