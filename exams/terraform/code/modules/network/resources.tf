# Create a VPC with a public and private subnet
resource "aws_vpc" "vpc" {

    cidr_block           = "10.0.0.0/16"
    enable_dns_support   = true
    enable_dns_hostnames = true

    tags = {
    Name = "${var.instance_name}-vpc"
    }
}

# Create a public subnet 1
resource "aws_subnet" "subnet_1" {

    vpc_id            = aws_vpc.vpc.id
    cidr_block        = "10.0.1.0/24"
    map_public_ip_on_launch = true #Subnet 1 is public

    tags = {
        Name = "${var.instance_name}-public-subnet"
    }
}

# Create an private subnet 2
resource "aws_subnet" "subnet_2" {

    vpc_id            = aws_vpc.vpc.id
    cidr_block        = "10.0.2.0/24"
    map_public_ip_on_launch = false #Subnet 2 is private

    tags = {
        Name = "${var.instance_name}-private-subnet"
    }
}

# Create an Internet Gateway
resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.vpc.id

    tags = {
        Name = "${var.instance_name}-igw"
    }
}


# Create a route table for the public subnet
resource "aws_route_table" "public_rt" {
    vpc_id = aws_vpc.vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }

    tags = {
        Name = "${var.instance_name}-public-rt"
    }
}


# Create a route table for the private subnet
resource "aws_route_table" "private_rt" {
    vpc_id = aws_vpc.vpc.id

    tags = {
        Name = "${var.instance_name}-private-rt"
    }
}


# Associate the public subnet with the public route table (Connection)
resource "aws_route_table_association" "public_rt_connect" {
    subnet_id      = aws_subnet.subnet_1.id
    route_table_id = aws_route_table.public_rt.id
}


# Associate the private subnet with the private route table (Connection)
resource "aws_route_table_association" "private_rt_connect" {
    subnet_id      = aws_subnet.subnet_2.id
    route_table_id = aws_route_table.private_rt.id
}