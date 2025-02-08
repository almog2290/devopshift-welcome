# SECURITY GROUP FOR ALB
resource "aws_security_group" "alb_sg" {
  name        = "${var.alb_name}-alb-sg"
  description = "Security group for ALB"

  vpc_id = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "alb-sg"
  }
}

# TARGET GROUP
resource "aws_lb_target_group" "tg" {
  name     = "${var.alb_name}-alb-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id = var.vpc_id

  health_check {
    enabled             = true
    interval            = 30
    path                = "/"
    port                = "traffic-port"
    protocol            = "HTTP"
    healthy_threshold   = 3
    unhealthy_threshold = 2
    timeout             = 5
  }

  tags = {
    Name = "${var.alb_name}-alb-tg"
  }
}


# REGISTER EC2 INSTANCES TO TARGET GROUP
resource "aws_lb_target_group_attachment" "tg_attachment" {
  for_each = { for idx, instance in [var.vm_instances]: idx => instance }

  target_group_arn = aws_lb_target_group.tg.arn
  target_id        = each.value.id
  port             = 80
}

# APPLICATION LOAD BALANCER
resource "aws_lb" "alb" {
  name               = "${var.alb_name}-app-load-balancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = var.subnets


  enable_deletion_protection = false

  tags = {
    Name = "${var.alb_name}-application-lb"
  }
}

# LISTENER
resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
}

# LAUNCH TEMPLATE
resource "aws_launch_template" "lt" {
  name          = "${var.alb_name}-launch-template"
  image_id      = var.ami_id
  instance_type = var.instance_type
  vpc_security_group_ids = [aws_security_group.alb_sg.id]

  user_data = base64encode(<<-EOF
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
  )
}

# AUTO SCALING GROUP
resource "aws_autoscaling_group" "asg" {
  name = "${var.alb_name}-asg"
  launch_template {
    id      = aws_launch_template.lt.id
    version = "$Latest"
  }
  min_size             = 1
  max_size             = 3
  desired_capacity     = 1
  vpc_zone_identifier  = var.subnets

  tag {
    key                 = "Name"
    value               = "${var.alb_name}-asg"
    propagate_at_launch = true
  }

  target_group_arns = [aws_lb_target_group.tg.arn]

  lifecycle {
    create_before_destroy = true
  }
}