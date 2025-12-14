module "frontend" {
  depends_on    = [module.backend]
  source        = "git::https://github.com/Shripad13/tf-module-terraform.git"
  instance_type = var.components["frontend"]["instance_type"]
  name          = var.components["frontend"]["name"]
  env           = var.env
  port_no       = var.components["frontend"]["port_no"]
  pwd           = var.pwd
}

module "backend" {
  depends_on    = [module.mysql]
  source        = "git::https://github.com/Shripad13/tf-module-terraform.git"
  instance_type = var.components["backend"]["instance_type"]
  name          = var.components["backend"]["name"]
  env           = var.env
  port_no       = var.components["backend"]["port_no"]
  pwd           = var.pwd
}

module "mysql" {
  source        = "git::https://github.com/Shripad13/tf-module-terraform.git"
  instance_type = var.components["mysql"]["instance_type"]
  name          = var.components["mysql"]["name"]
  env           = var.env
  port_no       = var.components["mysql"]["port_no"]
  pwd           = var.pwd
}

# rm -rf .terraform ; terraform init --backend-config=env-dev/state.tfvars ;terraform plan --var-file=env-dev/main.tfvars ; sleep 10;  terraform apply --var-file=env-dev/main.tfvars --auto-approve

# Create a VPC Module
module "vpc" {
  source          = "git::https://github.com/Shripad13/tf-module-vpc.git"
  for_each        = var.vpc
  vpc_cidr_block  = each.value["vpc_cidr_block"]
  lb_subnet_cidr  = each.value["lb_subnet_cidr"]
  eks_subnet_cidr = each.value["eks_subnet_cidr"]
  db_subnet_cidr  = each.value["db_subnet_cidr"]
  azs             = each.value["azs"]
  tags            = var.tags
  env             = var.env

  default_vpc_id   = each.value["default_vpc_id"]
  default_vpc_cidr = each.value["default_vpc_cidr"]
  default_vpc_rt   = each.value["default_vpc_rt"]
}

# Create a RDS Module
module "rds" {
  depends_on = [module.vpc]
  source     = "git::https://github.com/Shripad13/tf-module-rds.git"

  for_each       = var.rds
  engine         = each.value["engine"]
  engine_version = each.value["engine_version"]
  env            = var.env
  family         = each.value["family"]
  instance_class = each.value["instance_class"]

  eks_subnet_cidr = module.vpc["main"].eks_subnet_cidr
  vpc_id          = module.vpc["main"].vpc_id
  subnet_ids      = module.vpc["main"].rds_subnet_ids
}

# Create a EKS Module
module "eks" {
  depends_on = [module.vpc, module.rds]

  source      = "git::https://github.com/Shripad13/tf-module-eks.git"
  for_each    = var.eks
  tags        = var.tags
  env         = var.env
  eks_version = each.value["eks_version"]
  node_groups = each.value["node_groups"]

  subnet_ids = module.vpc["main"].eks_subnet_ids
}