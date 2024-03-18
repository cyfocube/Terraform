#Load Balancer
resource "aws_lb" "TM_lb" {
  name = "loadbalancer"
  load_balancer_type = "application"
  security_groups = [var.sec_gro_id]
  subnets = [var.TM_sub01_id,var.TM_sub02_id]
}

resource "aws_lb_target_group" "TM_lb_target" {
    name=var.targetname
    port = 80
    protocol = "HTTP"
    vpc_id = var.TM_vpcid
}

resource "aws_lb_listener" "TM_lb_UI" {
  load_balancer_arn = aws_lb.TM_lb.arn
  port = "80"
  protocol = "HTTP"
  
  default_action {
   type ="forward"
   target_group_arn = aws_lb_target_group.TM_lb_target.arn
  }
}
