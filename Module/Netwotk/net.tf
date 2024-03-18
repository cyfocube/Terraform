#VPC
resource "aws_vpc" "TM_vpc" {
  cidr_block = var.cidr_block

   tags = {
    Name = "${var.VPC_Name}-vpc"
  }
}
/*
## Things you can add to vpc
  instance_tenancy = "default"
  enable_dns_hostnames = true
  How to make vpc dynamic in case you creating more than one
   tags = {
    Name = "${var.VPC_Name}-vpc"
  }

  Code to get all availablity zone

*/

data "aws_availability_zones" "availability_zones"{}

#Public Subnet01
resource "aws_subnet" "TM_SubnetO1" {
  vpc_id = aws_vpc.TM_vpc.id
  cidr_block = var.Subnetblock01
 availability_zone = data.aws_availability_zones.availability_zones.names[0]
  map_public_ip_on_launch = true  # Automatically assign public IP
 
  tags = {
    Name = "${var.VPC_Name}-subnet01"
  }
}

#Public Subnet02
resource "aws_subnet" "TM_SubnetO2" {
  vpc_id = aws_vpc.TM_vpc.id
  cidr_block = var.Subnetblock02
  availability_zone = data.aws_availability_zones.availability_zones.names[1]
  map_public_ip_on_launch = true  # Automatically assign public IP
  tags = {
    Name = "${var.VPC_Name}-subnet02"
  }
}

/*
You can add availiability zone in the subnet
availability_zone = var.abc
*/

#Internet Gateway Resource 
resource "aws_internet_gateway" "TM_imt_gw" {
  vpc_id = aws_vpc.TM_vpc.id

    tags = {
    Name = "${var.VPC_Name}-igw"
  }
   
}


#Route Table for public subnet
resource "aws_route_table" "TM_rt_public" {
  vpc_id     = aws_vpc.TM_vpc.id

  route {
    cidr_block = var.allnetwork
    gateway_id = aws_internet_gateway.TM_imt_gw.id
  }
  tags = {
    Name = "${var.VPC_Name}-pub_rt"
  }
}


#Associate the route table with the public subnet01
resource "aws_route_table_association" "TM_rt_public_associa_subnet01" {
    subnet_id = aws_subnet.TM_SubnetO1.id
    route_table_id = aws_route_table.TM_rt_public.id
}

#Associate the route table with the public subnet02
resource "aws_route_table_association" "TM_rt_public_associa_subnet02" {
    subnet_id = aws_subnet.TM_SubnetO2.id
    route_table_id = aws_route_table.TM_rt_public.id
}

##Private SUbnets (Apps)
resource "aws_subnet" "TM_subnet03" {
  vpc_id = aws_vpc.TM_vpc.id
  cidr_block = var.Subnetblock03
 availability_zone = data.aws_availability_zones.availability_zones.names[0]
  map_public_ip_on_launch = false  # Automatically assign public IP
  tags = {
    Name = "${var.VPC_Name}-subnet03"
  }
}

resource "aws_subnet" "TM_subnet04" {
  vpc_id = aws_vpc.TM_vpc.id
  cidr_block = var.Subnetblock04
 availability_zone = data.aws_availability_zones.availability_zones.names[1]
  map_public_ip_on_launch = false  # Automatically assign public IP
  tags = {
    Name = "${var.VPC_Name}-subnet03"
  }
}

#Subnet (Data)
resource "aws_subnet" "TM_subnet05_data" {
  vpc_id = aws_vpc.TM_vpc.id
  cidr_block = var.Subnetblock05
 availability_zone = data.aws_availability_zones.availability_zones.names[0]
  map_public_ip_on_launch = false  # Automatically assign public IP
  tags = {
    Name = "${var.VPC_Name}-subnet05_data"
  }
}

resource "aws_subnet" "TM_subnet06_data" {
  vpc_id = aws_vpc.TM_vpc.id
  cidr_block = var.Subnetblock06
  availability_zone = data.aws_availability_zones.availability_zones.names[1]
  map_public_ip_on_launch = false  # Automatically assign public IP
  tags = {
    Name = "${var.VPC_Name}-subnet06_data"
  }
}

#Gateway for Private subnet
#Elastic IP for private gateway
resource "aws_eip" "TM_pr_elip" {
  depends_on = [ aws_internet_gateway.TM_imt_gw]
  ## vpc = true
  tags = {
    Name="${var.VPC_Name}-pr_nat"
  }

}

#Nat Gateway for private subnet
resource "aws_nat_gateway" "TM_nat_Pr_gw_subnet" {
  allocation_id = aws_eip.TM_pr_elip.id
  subnet_id = aws_subnet.TM_SubnetO1.id # Associate NAT with of the public subnet first

  tags = {
    Name="Tm NAT for private subnet"
  }

   depends_on = [aws_internet_gateway.TM_imt_gw]
  
}

#Route Table for connecting NAT
resource "aws_route_table" "TM_pr_rtable" {
  vpc_id = aws_vpc.TM_vpc.id

  route  {
   cidr_block  =var.allnetwork
   nat_gateway_id= aws_nat_gateway.TM_nat_Pr_gw_subnet.id

  }
}

#Associate the routable to the private subnet
resource "aws_route_table_association" "pr_subnet_asso03" {
  subnet_id = aws_subnet.TM_subnet03.id
  route_table_id = aws_route_table.TM_pr_rtable.id
}

resource "aws_route_table_association" "Pr_subnet_asso04" {
  subnet_id = aws_subnet.TM_subnet04.id
  route_table_id = aws_route_table.TM_pr_rtable.id
}



