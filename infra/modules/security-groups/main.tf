resource "aws_security_group" "alb_security_group" {
    name = var.alb_sg_name
    vpc_id = var.vpc_id  
# accept all traffic coming from ports 80 and 443
    ingress  {
    description = "allow inbound http access"
    from_port = 80
    to_port =   80
    cidr_blocks = ["0.0.0.0/0"]
    protocol = "tcp"
    }
   ingress {
    description = "allow  inbound https access"
    from_port = 443
    to_port = 443
    cidr_blocks = [ "0.0.0.0/0"]
    protocol = "tcp"
   }
# allow all outbound traffic
   egress {

    description = "allow all outbound traffic"
    from_port = 0
    to_port = 0
    cidr_blocks = [ "0.0.0.0/0"]
    protocol = "-1"
   }

   tags = {
     name = "alb security group"
   }




   }

