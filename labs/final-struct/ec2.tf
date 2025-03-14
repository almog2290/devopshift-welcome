resource "aws_security_group" "ec2_sg" {
  vpc_id = var.create_vpc ? aws_vpc.vpc.id : data.aws_vpc.default.id
  
  dynamic "ingress" {
    for_each = var.ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "vm" {
  ami           = var.ami 
  instance_type = var.instance_type
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
  associate_public_ip_address = var.associate_public_ip
  key_name = aws_key_pair.deployer_key.key_name
  
  subnet_id = var.create_vpc ? aws_subnet.subnet.id : data.aws_subnet.default.id

  depends_on = [aws_key_pair.deployer_key]

  tags = {
    Name = "${var.prefix_name}-vm"
  }
}

resource "aws_key_pair" "deployer_key" {
  key_name   = "deployer-key"
  public_key = file(var.ssh_key_path)
}