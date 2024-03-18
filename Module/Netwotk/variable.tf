
#VPC
variable "cidr_block" {}
variable "VPC_Name" {}

#Subnet
variable "Subnetblock01" {}
variable "Subnetblock02" {}
variable "Subnetblock03" {}
variable "Subnetblock04" {}
variable "Subnetblock05" {}
variable "Subnetblock06" {}


#RouteTable
variable "allnetwork" {
   default = "0.0.0.0/0"
}




