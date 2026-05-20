variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "ap-south-1"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "key_pair_name" {
  description = "AWS key pair name"
  type        = string
  default     = "terraform_ec2_keypair"
  sensitive = true
}

variable "instance_name" {
  description = "EC2 instance Name tag"
  type        = string
  default     = "Ubuntu-Server-Terraform"
}

variable "tags" {
  description = "Common tags"
  type        = map(string)
  default     = {
    Project = "Terraform-EC2"
    Owner   = "Varun"
  }
}
