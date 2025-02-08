output "alb_sg" {
    value = aws_security_group.alb_sg.id
    description = "ID of the Application Load Balancer Security Group"
}

output "tg" {
    value = aws_lb_target_group.tg.arn
    description = "ARN of the Target Group"
}

output "tg_attachment" {
    value = aws_lb_target_group_attachment.tg_attachment
    description = "List of EC2 instances attached to the Target Group"
}

output "alb" {
    value = aws_lb.alb.dns_name
    description = "DNS name of the Application Load Balancer"
}