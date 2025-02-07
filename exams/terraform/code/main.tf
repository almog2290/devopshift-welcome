module "network_setup" {
    source = "./modules/network"
    instance_name = "AM-devops"
}

output "network_information" {
    value = module.network_setup
    description = "The network information"
}

