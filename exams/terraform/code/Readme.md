# Terraform Workshop - Exam Hands-On :

This project sets up a basic infrastructure on AWS using Terraform.
It includes a VPC with public and private subnets, an EC2 instance, and an Application Load Balancer (ALB).

## Modules
### Network Module

The network module sets up the VPC, subnets, and route tables.

- **Source:** `./modules/network`
- **Variables:**
  - `instance_name`: Name of the network instance

### EC2 Module

The EC2 module sets up an EC2 instance with a security group.

- **Source:** `./modules/ec2`
- **Variables:**
  - `ami`: AMI ID for the EC2 instance
  - `instance_type`: Type of the EC2 instance
  - `vm_name`: Name of the EC2 instance
  - `associate_public_ip`: Whether to associate a public IP address
  - `vpc_id`: VPC ID
  - `custom_subnet_id`: Subnet ID
  - `ports`: List of ports to open

### ALB Module

The ALB module sets up an Application Load Balancer with a target group and listener.

- **Source:** `./modules/alb`
- **Variables:**
  - `alb_name`: Name of the ALB
  - `vpc_id`: VPC ID
  - `subnets`: List of subnets
  - `vm_instances`: List of EC2 instances
  - `ami_id`: AMI ID for the EC2 instances
  - `instance_type`: Type of the EC2 instances

## Outputs

- `network_details`: Details of the network module
- `ec2_details`: Details of the EC2 module
- `alb_details`: Details of the ALB module