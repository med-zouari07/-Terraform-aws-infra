module "vpc" {
  source              = "./modules/vpc"
  vpc_cidr            = var.vpc_cidr
  public_subnet_cidr  = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr
  az                  = var.az
}

module "ec2" {
  source          = "./modules/ec2"
  ami_id          = var.ami_id
  instance_type   = var.instance_type
  public_subnet_id = module.vpc.public_subnet_id
  key_name        = var.key_name
}

module "rds" {
  source          = "./modules/rds"
  db_name         = var.db_name
  db_username     = var.db_username
  db_password     = var.db_password
  private_subnet_id = module.vpc.private_subnet_id
}