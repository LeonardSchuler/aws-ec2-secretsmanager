resource "random_string" "suffix" {
  length  = 8
  special = false
}


module "iam_policy" {
  source = "terraform-aws-modules/iam/aws//modules/iam-policy"

  description = "Read and write access to a secret in Secrets Manager."

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "secretsmanager:GetSecretValue",
        "secretsmanager:PutSecretValue"
      ],
      "Effect": "Allow",
      "Resource": "${var.secret_arn}"
    }
  ]
}
EOF
}


module "security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 5.0"

  name        = "${var.name}-ec2-${random_string.suffix.result}"
  description = "Security Group for EC2"

  vpc_id = var.vpc_id


  tags = var.tags
}

module "ec2" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 5.0"

  name                   = var.name
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [module.security_group.security_group_id]

  ami_ssm_parameter = "/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"
  instance_type     = var.instance_type

  #associate_public_ip_address = true

  create_iam_instance_profile = true
  iam_role_description        = "IAM role for EC2 instance"
  iam_role_policies = {
    AmazonSSMManagedInstanceCore = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore",
    Custom                       = module.iam_policy.arn
  }
  # fix: needed for SSM to start properly
  user_data = <<-EOT
    #!/bin/bash
    sudo systemctl restart amazon-ssm-agent.service
  EOT

  tags = var.tags
}
