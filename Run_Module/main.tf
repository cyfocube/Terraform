#Configure AWS Provider
provider "aws" {
region = var.region
  access_key = var.access_key
  secret_key = var.secret_key
 // profile = "terraform-project"
}



#Network Module
module "network" {
  source = "../Module/Netwotk"
  cidr_block = var.cidr_block
  Subnetblock01 = var.Subnetblock01
  Subnetblock02 = var.Subnetblock02
  Subnetblock03 = var.Subnetblock03
  Subnetblock04 = var.Subnetblock04
  Subnetblock05 = var.Subnetblock05
  Subnetblock06 = var.Subnetblock06
  VPC_Name = var.VPC_Name
  allnetwork=var.allnetwork
  
}

output "available_availability_zones" {
   description = "List of available availability zones."
  value = module.network.available_availability_zones
}

#Server Module
module "server" {
  source = "../Module/Server"
  ecename=var.ecename
  imagename = var.imagename
  inst_type = var.inst_type
  instancename = var.instancename
  TM_vpcid = module.network.TM_vpcid
  TM_sub02_id = module.network.TM_sub02_id
  secgname_instance = var.secgname_instance
  secgname_lb = var.secgname_lb
  num_instance = var.num_instance
  

}

#Lo Module
module "lb" {
  source = "../Module/LB"
  targetname = var.targetname
  TM_vpcid=module.network.TM_vpcid
  sec_gro_id = module.server.sec_gro_id
  TM_sub01_id = module.network.TM_sub01_id
  TM_sub02_id = module.network.TM_sub02_id

}

/*
terraform init
terraform plan
terraform apply
terraform destroy
*/