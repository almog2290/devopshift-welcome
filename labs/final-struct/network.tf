# Create a VPC with a public subnet
resource "aws_vpc" "vpc" {
    count = var.create_vpc ? 1 : 0

    cidr_block           = var.cidr_block_vpc
    enable_dns_support   = true
    enable_dns_hostnames = true

    tags = {
    Name = "${var.prefix_name}-vpc"
    }
}

# Create a public subnet 1
resource "aws_subnet" "subnet" {
    count = var.create_vpc ? 1 : 0

    vpc_id            = aws_vpc.vpc.id
    cidr_block        = var.cidr_block_subnet
    map_public_ip_on_launch = true #Subnet 1 is public
    availability_zone = random_shuffle.random_az.result[0]
    
    tags = {
        Name = "${var.prefix_name}-public-subnet"
    }
}

# Get default VPC and default subnet if custom VPC is not created
data "aws_vpc" "default" {
 default = true
}


data "aws_subnet" "default" {
 depends_on = [random_shuffle.random_az]
 filter {
   name   = "default-for-az"
   values = ["true"]
 }
 filter {
   name   = "availability-zone"
   values = [random_shuffle.random_az.result[0]]

 }
}


# Create an Internet Gateway
resource "aws_internet_gateway" "igw" {
    vpc_id = var.create_vpc ? aws_vpc.vpc.id : data.aws_vpc.default.id

    tags = {
        Name = "${var.prefix_name}-igw"
    }
}

# Create a route table for the public subnet
resource "aws_route_table" "public_rt" {
    vpc_id = var.create_vpc ? aws_vpc.vpc.id : data.aws_vpc.default.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }

    tags = {
        Name = "${var.prefix_name}-public-rt"
    }
}

# Associate the public subnet with the public route table (Connection)
resource "aws_route_table_association" "public_rt_connect" {
    subnet_id      = var.create_vpc ? aws_subnet.subnet.id : data.aws_subnet.default.id
    route_table_id = aws_route_table.public_rt.id
}

# Randomly select an availability zone
resource "random_shuffle" "random_az" {
  input        = var.az_list
  result_count = 1
}