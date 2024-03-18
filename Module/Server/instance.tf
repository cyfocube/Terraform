#Instance Creation Launch-template
resource "aws_launch_template" "TM_ec2" {
  name_prefix = var.ecename
  image_id = var.imagename  #ami-.... (Machine -Window, Mac, Ubutun etc)
  instance_type = var.inst_type  # "t2-micro"for example --CPU

network_interfaces {
    subnet_id = var.TM_sub02_id
    security_groups = [aws_security_group.TM_sec_group_for_ec2.id]
  
}
  tag_specifications {
    resource_type = "instance"
  tags = {
    Name=var.instancename
  }
  }

}

# Launch Instance using Launch Template
resource "aws_instance" "TM_ec2_instance" {
  count             = var.num_instance
  launch_template {
    id      = aws_launch_template.TM_ec2.id
    version = "$Latest"
  }
}

## Auto-Scaling



##We can create public key and private key for EC2 instances too 
##Not sure!, we can also enable public IP
## Above note is what I see on a  Youtube tutorial online when you manually create EC2

resource "aws_security_group" "TM_sec_group_for_lb" {
  name = var.secgname_lb
  vpc_id = var.TM_vpcid

  ingress =[ {
      description     =   "Allow all htttp"
      protocol        =   "tcp"
      from_port       =    80
      to_port         =    80
      cidr_blocks      =   ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
      prefix_list_ids = []
      security_groups = []
      self = false
  }]
    
  
  egress = [ {
    description      = "for all outgoing traffics"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
     prefix_list_ids = []
     security_groups = []
     self = false
  }]
  
  
}


resource "aws_security_group" "TM_sec_group_for_ec2" {
  name = var.secgname_instance
  vpc_id = var.TM_vpcid

  ingress =[ {
      description="Allow all htttp from load balancer"
      protocol="tcp"
      from_port = 80  # range of 
      to_port= 80  # port numbers
      cidr_blocks = ["0.0.0.0/0"]
      security_groups=[aws_security_group.TM_sec_group_for_lb.id]
      ipv6_cidr_blocks = ["::/0"]
     prefix_list_ids = []
     self = false
  },
  {
      description      = "Allow RDP from anywhere"
      protocol         = "tcp"
      from_port        = 3389
      to_port          = 3389
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    },
  ]
  egress =[ {
     description="for all outgoing traffic"
      from_port  =  0
      to_port    =   0
      protocol   =  "-1"
      cidr_blocks = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
     prefix_list_ids = []
     security_groups = []
     self = false
      
  }]
}



