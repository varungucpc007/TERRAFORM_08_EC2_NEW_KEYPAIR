# TERRAFORM_08_EC2_NEW_KEYPAIR

## Project Overview

This Terraform project creates a new AWS key pair and launches an EC2 instance using that key pair.

## What This Project Creates

- New AWS EC2 key pair
- One EC2 instance
- Security group if configured
- Output values for connection details

## Technologies Used

| Technology | Purpose |
| --- | --- |
| Terraform | Infrastructure as Code |
| AWS EC2 | Virtual server |
| AWS Key Pair | SSH access |

## Recommended Files

```text
TERRAFORM_08_EC2_NEW_KEYPAIR/
├── provider.tf
├── keypair.tf
├── ec2.tf
├── variables.tf
├── outputs.tf
└── README.md
```

## Key Pair Concept

Terraform can create an AWS key pair using a public key.

Example resource:

```hcl
resource "aws_key_pair" "new_key" {
  key_name   = "terraform-new-key"
  public_key = file("terraform-new-key.pub")
}
```

## Generate SSH Key Locally

```bash
ssh-keygen -t rsa -b 4096 -f terraform-new-key
```

This creates:

- `terraform-new-key`
- `terraform-new-key.pub`

## Terraform Commands

```bash
terraform init
terraform validate
terraform plan
terraform apply
```

Type `yes` when prompted.

## SSH Into EC2

```bash
ssh -i terraform-new-key ubuntu@PUBLIC_IP
```

## Destroy Resources

```bash
terraform destroy
```

## Important Notes

- Keep private keys secure.
- Commit only public keys if required.
- Do not commit private key files.
- AWS key pair names must be unique in a region.
