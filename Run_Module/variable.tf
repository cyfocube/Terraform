#Main file
variable "region" {
  default = "us-east-1"
}


variable "access_key" {
  default = ""

}
variable "secret_key" {
  default = ""
}

#some of the variables are repeated to I remove the duplication in each section
#Nerwork ///////
#VPC
variable "cidr_block" {
    default = "10.0.0.0/16"
}
variable "VPC_Name" {
    default = "TM_Project"
}

#Subnet
variable "Subnetblock01" {
    default = "10.0.1.0/24"
}


variable "Subnetblock02" {
    default = "10.0.2.0/24"
}

variable "Subnetblock03" {
    default = "10.0.3.0/24"
}

variable "Subnetblock04" {
    default = "10.0.4.0/24"
}

variable "Subnetblock05" {
default = "10.0.5.0/24"
}
variable "Subnetblock06" {
default = "10.0.6.0/24"
}

#RouteTable
variable "allnetwork" {
   default = "0.0.0.0/0"
}
 ///////


#Load Balancer
variable "targetname" {
    default = "tgname"
}


#Instance
variable "ecename" {
    default = "TM_EC2"
}
variable "imagename" {
    description = "Instatnce amazon machine image"
    type        = string
    default = "ami-018ab3d2d65bce6eb"
}
variable "inst_type" {
    description = "Instatnce type t2.micro"
    type       = string
    default = "t2.micro"
}
variable "instancename" {
    default = "terraform_TM_EC2_main"
}

variable "num_instance" {
    default = 2
}



#Security Group for elastic lb and ec2
variable "secgname_lb" {
    default = "secgroup_loadbal"
}
variable "secgname_instance" {
    default = "ter_secg_instance"
}





