locals {
  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
  region      = "us-east-1"
  vpc_name    = "my-vpc"
  secret_name = "ec2secret"
  ec2_name    = "Webserver"
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
  source     = "../../modules/ec2"
  tags       = local.tags
  subnet_id  = module.vpc.public_subnets[1]
  vpc_id     = module.vpc.vpc_id
  secret_arn = module.secrets.secret_arn
  name       = local.ec2_name
}
