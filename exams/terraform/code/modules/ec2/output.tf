output "vm_instance" {
  value = aws_instance.vm
  description = "EC2 instance details"
}

output "ec2_sg" {
  value = aws_security_group.ec2_sg
  description = "Security group details"
}

output "vm_public_ip" {
  value       = aws_instance.vm.public_ip
  depends_on  = [time_sleep.wait_for_ip]  # Wait for the time_sleep resource to complete
  description = "Public IP address of the VM"
}
