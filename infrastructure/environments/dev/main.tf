locals {
  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
  region      = "us-east-1"
  vpc_name    = "my-vpc"
  secret_name = "ec2secret"
}


module "vpc" {
  source = "../../modules/vpc"
  region = local.region
  name   = local.vpc_name
  tags   = local.tags
}

module "secrets" {
  source = "../../modules/secrets"
  name   = local.secret_name
  tags   = local.tags
}

module "ec2" {
  source    = "../../modules/ec2"
  tags      = local.tags
  subnet_id = module.vpc.public_subnets[1]
  vpc_id    = module.vpc.vpc_id
  name      = "Secret"
}

output "secret_arn" {
  description = "Use to access Secret"
  value       = module.secrets.secret_arn
}

output "ssm_ssh_session_command" {
  description = "Command to start SSH like session (using SSM)"
  value       = "aws ssm start-session --target ${module.ec2.instance_id} --region ${local.region}"
}

output "ssm_ssh_port_forwarding_session_command" {
  description = "Command to port forward from EC2 to local"
  value       = <<-EOT
aws ssm start-session --target ${module.ec2.instance_id} --region ${local.region} --document-name AWS-StartPortForwardingSession --parameters '{"localPortNumber":["8080"],"portNumber":["8000"]}'
  EOT
}
