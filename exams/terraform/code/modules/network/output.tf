# Output the ID of the VPC
output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.vpc.id
}

# Output the ID of the public subnet
output "subnet_1_id" {
  description = "The ID of the public subnet"
  value       = aws_subnet.subnet_1.id
}

# Output the ID of the private subnet
output "subnet_2_id" {
  description = "The ID of the private subnet"
  value       = aws_subnet.subnet_2.id
}

# Output the ID of the Internet Gateway
output "internet_gateway_id" {
  description = "The ID of the Internet Gateway"
  value       = aws_internet_gateway.igw.id
}

# Output the ID of the public route table
output "public_route_table_id" {
  description = "The ID of the public route table"
  value       = aws_route_table.public_rt.id
}

# Output the ID of the private route table
output "private_route_table_id" {
  description = "The ID of the private route table"
  value       = aws_route_table.private_rt.id
}

output "availability_zone_selection" {
  description = "The availability zone selection"
  value       = random_shuffle.random_az.result
}
