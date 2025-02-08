module "network_instance_1" {
    source = "./network"
    region = var.region
    instance_name = var.network_instance_name
}

module "ec2_instance_1" {
    source = "./ec2"
    region = var.region
    ami = var.ami
    instance_type = var.instance_type
    name = var.vm_name
    ports = var.ports
}

output "complete_network_ec2" {
    value = {
        network_instance = module.network_instance_1
        ec2_instance_1 = module.ec2_instance_1
    }

    description = "Complete network and EC2 instance"
}