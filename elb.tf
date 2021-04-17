resource "aws_lb" "cluster_load_balancer" {
  name               = "edge-cluster"
  internal           = false
  load_balancer_type = "network"
  subnets            = [ aws_subnet.external_subnet.id ]
}

resource "aws_lb_listener" "lb_listener" {
  load_balancer_arn  = aws_lb.cluster_load_balancer.arn
  protocol           = "TCP"
  port               = 80
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.hosts_target_group.arn
  }
}

resource "aws_lb_target_group" "hosts_target_group" {
  name       = "container-instances-target-group"
  vpc_id     = aws_vpc.primary_vpc.id
  port       = 80
  protocol   = "TCP"
  depends_on = [
    aws_lb.cluster_load_balancer
  ]
  health_check {
    interval = 10
  }
}

data "template_file" "user_data" {
  template = file("./apply_cluster_name.sh")

  vars = {
    cluster_name = var.ecs_cluster_name
  }
}

resource "aws_launch_template" "foobar" {
  name_prefix          = "agnt-instance-"
  user_data            = base64encode(data.template_file.user_data.rendered)
  iam_instance_profile {
    name = aws_iam_instance_profile.ecs_agent.name
  }
  image_id               = data.aws_ami.ecs_ami.image_id
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.ecs_sg.id]
}