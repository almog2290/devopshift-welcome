module "ec2" {
    source = "./modules/ec2"
    ami = "ami-0ff8a91507f77f867"
    instance_type = "t2.micro"
    name = "almog-devops-vm"
    ports = ["22","80"]
    region = "us-east-1"
}

output "ec2_information" {
    value = module.ec2
    description = "The ec2 instance information" 
}