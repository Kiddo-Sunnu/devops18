resource "aws_launch_template" "web_server_as" {
    name = "myproject"
    image_id = "ami-0150ccaf51ab55a51"  #N.VIRGINIA REGION AMI-ID
    vpc_security_group_ids = [aws_security_group.web_server.id]
    instance_type = "t2.micro"
    key_name = "Rakesh1"
    tags = {
        Name = "DevOps"
    }
    
}
   


  resource "aws_elb" "web_server_lb"{
     name = "web-server-lb"
     security_groups = [aws_security_group.web_server.id]
     subnets = ["subnet-051c8f9642b778e8a", "subnet-008941aa1892b9ac2"]     #WRITE THE CHANGES go to VPC tab and click on SUBNETS and copy paste the subnet ids here.
     listener {
      instance_port     = 8000
      instance_protocol = "http"
      lb_port           = 80
      lb_protocol       = "http"
    }
    tags = {
      Name = "terraform-elb"
    }
  }
resource "aws_autoscaling_group" "web_server_asg" {
    name                 = "web-server-asg"
    min_size             = 1
    max_size             = 3
    desired_capacity     = 2
    health_check_type    = "EC2"
    load_balancers       = [aws_elb.web_server_lb.name]
    availability_zones    = ["us-east-1a", "us-east-1b"] 
    launch_template {
        id      = aws_launch_template.web_server_as.id
        version = "$Latest"
      }
    
    
  }

