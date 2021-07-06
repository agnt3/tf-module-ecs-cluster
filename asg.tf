resource "aws_autoscaling_group" "autoscaling" {
  name                = "autoscaling-${aws_launch_template.container_instance_launch_template.name}-3"
  desired_capacity    = var.asg_desired_instances
  max_size            = var.asg_max_instances
  min_size            = var.asg_min_instances
  vpc_zone_identifier = [aws_subnet.private_subnet.id]
  health_check_type   = "EC2"
  launch_template {
    id = aws_launch_template.container_instance_launch_template.id
  }
  lifecycle {
    create_before_destroy = true
  }
}