
module "network" {
    source = "./modules/network"
    instance_name = "AM-devops"
}

module "ec2" {
  source = "./modules/ec2"
  ami = "ami-0ecc0e0d5986a576d" # Ubuntu 22.04 AMI in us-east-1 (Custom AMI)
  instance_type = "t2.micro"
  vm_name = "AM-devops"
  associate_public_ip = true
  vpc_id = module.network.vpc_id
  custom_subnet_id = module.network.subnet_1_id
  ports = [22, 80]
}

module "alb" {
  source = "./modules/alb"
  alb_name = "AM-devops"
  vpc_id = module.network.vpc_id
  subnets = [module.network.subnet_1_id, module.network.subnet_2_id]
  vm_instances = module.ec2.vm_instance
  ami_id = "ami-0ecc0e0d5986a576d"
  instance_type = "t2.micro"
}

output "network_details" {
  value = module.network  
}

output "ec2_details" {
  value = module.ec2
}

output "alb_details" {
  value = module.alb
}
