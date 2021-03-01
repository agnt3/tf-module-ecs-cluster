resource "aws_autoscaling_group" "autoscaling" {
  name                = "autoscaling-${aws_launch_template.foobar.name}-3"
  desired_capacity    = 2
  max_size            = 3
  min_size            = 2
  vpc_zone_identifier = [aws_subnet.internal_subnet.id]
  health_check_type   = "EC2"
  launch_template {
    id = aws_launch_template.foobar.id
  }
  lifecycle {
    create_before_destroy = true
  }
}