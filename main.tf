terraform {
  required_version = ">= 1.0"

  backend "s3" {}
}

locals {
  tags = {
    Terraform   = "true"
    Environment = "dev"
    Owner       = var.extra_tag_owner
  }
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.14.0"

  name = "${var.env_name}-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["eu-central-1a", "eu-central-1b", "eu-central-1c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway = true

  private_subnet_tags = {
    Tier = "Private"
  }

  public_subnet_tags = {
    Tier = "Public"
  }

  tags = local.tags
}

module "aws_key_pair" {
  source  = "cloudposse/key-pair/aws"
  version = "0.18.0"

  attributes          = ["ssh", "key"]
  ssh_public_key_path = "./secrets" # expects a key at ./secrets/ssh-key.pub
  generate_ssh_key    = false
}

module "bastion" {
  source  = "cloudposse/ec2-bastion-server/aws"
  version = "0.30.0"

  name                        = "${var.env_name}-bastion"
  enabled                     = true
  instance_type               = "t2.micro"
  security_groups             = [module.vpc.default_security_group_id]
  subnets                     = module.vpc.public_subnets
  key_name                    = module.aws_key_pair.key_name
  vpc_id                      = module.vpc.vpc_id
  associate_public_ip_address = true

  tags = {
    Terraform   = "true"
    Environment = "dev"
    Owner       = var.extra_tag_owner
  }
}