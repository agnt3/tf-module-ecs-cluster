resource "aws_lb" "cluster_load_balancer" {
  name               = "edge-cluster"
  load_balancer_type = "network"
  internal           = false
  subnets            = [ aws_subnet.public_subnet.id ]
}

data "template_file" "user_data" {
  template = file("./apply_cluster_name.tpl")

  vars = {
    cluster_name = var.ecs_cluster_name
  }
}

resource "aws_launch_template" "container_instance_launch_template" {
  name_prefix            = "container-instance-"
  user_data              = base64encode(data.template_file.user_data.rendered)
  image_id               = data.aws_ami.ecs_ami.image_id
  instance_type          = var.launch_template_instance_type
  vpc_security_group_ids = [ aws_security_group.ecs_sg.id ]

  iam_instance_profile {
    name = aws_iam_instance_profile.ecs_agent.name
  }
}