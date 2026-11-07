
terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = var.common_tags
  }
}

module "vpc" {
  source = "./modules/vpc"

  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
}

module "security_groups" {
  source = "./modules/security_groups"

  vpc_id             = module.vpc.vpc_id
  allowed_admin_cidr = var.allowed_admin_cidr
}

module "load_balancers" {
  source = "./modules/load_balancers"

  vpc_id             = module.vpc.vpc_id
  public_subnet_ids  = module.vpc.public_subnet_ids
  private_subnet_ids = module.vpc.private_subnet_ids
  public_alb_sg_id   = module.security_groups.public_alb_sg_id
  private_alb_sg_id  = module.security_groups.private_alb_sg_id
}

module "compute" {
  source = "./modules/compute"

  ami_id               = var.ami_id
  instance_type        = var.instance_type
  ssh_key_name         = var.ssh_key_name
  private_subnet_ids   = module.vpc.private_subnet_ids
  web_sg_id            = module.security_groups.web_sg_id
  app_sg_id            = module.security_groups.app_sg_id
  database_sg_id       = module.security_groups.database_sg_id
  web_target_group_arn = module.load_balancers.web_target_group_arn
  app_target_group_arn = module.load_balancers.app_target_group_arn
}
