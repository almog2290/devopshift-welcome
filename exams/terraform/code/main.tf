module "complete_network_ec2" {
    source = "./modules/complete_network_ec2"
    network_instance_name = "AM-devops"
    ami = "ami-0e1bed4f06a3b463d" # Ubuntu 22.04 AMI in us-east-1
    instance_type = "t2.micro"
    vm_name = "AM-devops"
    ports = [22, 80]
}

output "complete_network_ec2_info" {
    value = module.complete_network_ec2
    description = "Complete network and EC2 instance"
}

