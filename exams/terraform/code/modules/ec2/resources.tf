resource "aws_security_group" "ec2_sg" {
  vpc_id = var.vpc_id

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
  
  subnet_id = var.custom_subnet_id

  tags = {
    Name = var.vm_name
  }

 user_data = <<-EOF
   #cloud-config
   users:
     - name: "${var.admin_username}"
       groups: sudo
       shell: /bin/bash
       sudo: ["ALL=(ALL) NOPASSWD:ALL"]
       lock_passwd: false
       passwd: $(echo ${var.admin_password} | openssl passwd -6 -stdin)
   packages:
     - apache2
   runcmd:
     - sudo apt update
     - sudo apt install -y apache2
     - echo "<h1>Welcome to the Web Server $(hostname -f)</h1>" | sudo tee /var/www/html/index.html
     - sudo systemctl start apache2
     - sudo systemctl enable apache2
   EOF
}

resource "time_sleep" "wait_for_ip" {
  create_duration = "45s"  # Introduce a delay of 30 seconds
}
