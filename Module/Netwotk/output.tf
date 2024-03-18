#Output
output "TM_vpcid" {
  value = aws_vpc.TM_vpc.id
}

output "TM_sub01_id" {
  value = aws_subnet.TM_SubnetO1.id
}

output "TM_sub02_id" {
  value = aws_subnet.TM_SubnetO2.id
}

output "TM_sub03_id" {
  value = aws_subnet.TM_subnet03.id
}

output "TM_sub04_id" {
  value = aws_subnet.TM_subnet04.id
}

output "TM_sub05_id" {
  value = aws_subnet.TM_subnet05_data.id
}

output "TM_sub06_id" {
  value = aws_subnet.TM_subnet06_data.id
}

output "gtwy_id" {
  value=aws_internet_gateway.TM_imt_gw.id
}

//Other to be userd in other folders
output "VarName" {
  value=var.VPC_Name
}


output "available_availability_zones" {
  description = "List of available availability zones."
  value       = data.aws_availability_zones.availability_zones.names
}
