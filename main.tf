# 🔹 Fetch latest Ubuntu 22.04 AMI dynamically
data "aws_ami" "ubuntu_22_04" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

# 1️⃣ Generate a new private/public key pair
resource "tls_private_key" "ec2_key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

# 2️⃣ Create AWS key pair using generated public key
resource "aws_key_pair" "ec2_key_pair" {
  key_name   = var.key_pair_name
  public_key = tls_private_key.ec2_key.public_key_openssh
}

resource "local_file" "private_key_file" {
  content          = tls_private_key.ec2_key.private_key_pem
  filename         = "${path.module}/.${var.key_pair_name}.pem"
  file_permission  = "0600"
  
}

# 3️⃣ Security group allowing SSH
resource "aws_security_group" "ssh_access" {
  name        = "ssh_access"
  description = "Allow SSH inbound traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # ⚠ Restrict in production
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.tags
}

# 4️⃣ Launch EC2 instance
resource "aws_instance" "ubuntu_server" {
  ami                    = data.aws_ami.ubuntu_22_04.id
  instance_type          = var.instance_type
  key_name               = aws_key_pair.ec2_key_pair.key_name
  vpc_security_group_ids = [aws_security_group.ssh_access.id]

  tags = merge(
    var.tags,
    {
      Name = var.instance_name
    }
  )
}
