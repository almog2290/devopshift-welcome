resource "aws_security_group" "sg" {
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
  vpc_security_group_ids = [aws_security_group.sg.id]
  associate_public_ip_address = true

  tags = {
    Name = var.name
  }
}

resource "time_sleep" "wait_for_ip" {
  create_duration = "45s"  # Introduce a delay of 30 seconds
}
