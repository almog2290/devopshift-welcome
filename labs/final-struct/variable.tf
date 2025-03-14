######## Variables ########
# aws region
variable "region" {
  default = "us-east-1"
  description = "AWS region"
}

# availability zones
variable "az_list" {
 default = ["us-east-1a","us-east-1b","us-east-1c","us-east-1d" , "us-east-1e" , "us-east-1f"]
}

# prefix name
variable "prefix_name" {
  default = "AM-devops"
  description = "Prefix name"
}

# public key path
variable "ssh_key_path" {
  description = "Path to the SSH public key for access"
  type        = string
  default     = "~/.ssh/id_rsa_terraform.pub"
}

variable "ssh_key_path_private" {
  description = "Path to the SSH private key for access"
  type        = string
  default     = "~/.ssh/id_rsa_terraform"
  
}

######## Network variables ########

# create vpc
variable "create_vpc" {
 type    = bool
 default = true
 description = "Create a new VPC"
}

variable "cidr_block_vpc" {
  default = "172.24.0.0/16"
  description = "CIDR block for the VPC"
}

variable "cidr_block_subnet" {
  default = "172.24.5.0/24"
  description = "CIDR block for the subnet"
}


######## EC2 instance variables ########
#  AMI ID
variable "ami" {
  default = "ami-0c02fb55956c7d316" # Ubuntu AMI in us-east-1
  description = "AMI ISO number"
}

# instance type
variable "instance_type" {
  default = "t2.micro"
  description = "Instance type"
}

# open ports
variable "ports" {
  default = [22,5001]
  type = list(number)
  description = "Open ports of VM (ingress)"
}

variable "associate_public_ip" {
  default = true
  description = "Whether to associate a public IP address with the instance"
}
