resource "time_sleep" "wait_for_ip" {
  depends_on = [ aws_instance.vm ]
  create_duration = "45s"  # Introduce a delay of 45 seconds
}

resource "null_resource" "install_dockerAndDockerCompose" {
  depends_on = [ time_sleep.wait_for_ip ]

  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      user        = "ubuntu"  # Adjust based on your AMI's default user
      private_key = file(var.ssh_key_path_private)  # Path to your private key
      host        = aws_instance.vm.public_ip
    }

    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y docker.io",
      "sudo curl -L \"https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)\" -o /usr/local/bin/docker-compose",
      "sudo chmod +x /usr/local/bin/docker-compose"
    ]
  }
}