output "vpc_subnet_info" {
 value = var.create_vpc ? "The following is your VPC: ${aws_vpc.vpc.id} and Subnet: ${aws_subnet.subnet.id}" : "Using default VPC (${data.aws_vpc.default.id}) and Subnet (${data.aws_subnet.default.id})"
 description = "values of VPC and Subnet"
}

output "internet_gateway_id" {
  value       = aws_internet_gateway.igw.id
  description = "The ID of the Internet Gateway"
}

output "route_table_id" {
  value       = aws_route_table.public_rt.id
  description = "The ID of the public route table"
}

output "ec2_instance_public_ip" {
  value       = aws_instance.vm.public_ip
  description = "The public IP address of the EC2 instance"
}