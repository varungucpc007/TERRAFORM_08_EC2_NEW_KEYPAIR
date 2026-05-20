output "private_key_pem" {
  description = "Private key to SSH into EC2"
  value       = tls_private_key.ec2_key.private_key_pem
  sensitive   = true
}

output "instance_public_ip" {
  description = "Public IP of the Ubuntu EC2 instance"
  value       = aws_instance.ubuntu_server.public_ip
}

output "instance_id" {
  description = "ID of the Ubuntu EC2 instance"
  value       = aws_instance.ubuntu_server.id
}

