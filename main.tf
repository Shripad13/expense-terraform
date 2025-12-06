module "frontend" {
    depends_on = [module.backend]     
    source = "git::https://github.com/Shripad13/tf-module-terraform.git"
    instance_type = var.components["frontend"]["instance_type"]
    name          = var.components["frontend"]["name"]
    env           = var.env
    port_no       = var.components["frontend"]["port_no"]
    pwd             = var.pwd
}

module "backend" {
    depends_on = [module.mysql]
    source = "git::https://github.com/Shripad13/tf-module-terraform.git"
    instance_type = var.components["backend"]["instance_type"]
    name          = var.components["backend"]["name"]
    env           = var.env
    port_no       = var.components["backend"]["port_no"]  
    pwd             = var.pwd    
}

module "mysql" {   
    source = "git::https://github.com/Shripad13/tf-module-terraform.git"
    instance_type = var.components["mysql"]["instance_type"]
    name          = var.components["mysql"]["name"]
    env           = var.env
    port_no       = var.components["mysql"]["port_no"]  
    pwd             = var.pwd    
}

# rm -rf .terraform ; terraform init --backend-config=env-dev/state.tfvars ;terraform plan --var-file=env-dev/main.tfvars ; sleep 10;  terraform apply --var-file=env-dev/main.tfvars --auto-approve

# Create a VPC Module
module "vpc" {   
    source = "git::https://github.com/Shripad13/tf-module-terraform.git"
    env           = var.env
}