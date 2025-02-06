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
  ami           = var.ami # Amazon Linux 2 AMI in us-east-1
  instance_type = var.instance_type

  vpc_security_group_ids = [aws_security_group.sg.id]

  tags = {
    Name = var.name
  }
}

resource "time_sleep" "wait_for_ip" {
  create_duration = "30s"  # Introduce a delay of 30 seconds
}

resource "null_resource" "run_script_echo" {
  depends_on = [time_sleep.wait_for_ip]
  provisioner "local-exec" {
    command = "echo 'Hello Jb Class'"
  }
}
