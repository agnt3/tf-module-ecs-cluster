################# VPC #################
variable "vpc_private_subnet_cidr" {
  type = string
  description = "CIDR of VPC private subnet."
}

variable "vpc_public_subnet_cidr" {
  type = string
  description = "CIDR of VPC public subnet."
}

variable "vpc_security_groups_ids" {
  type = list(string)
  description = "List with ID's security groups used container instances."
}

################# ECS #################
variable "ecs_cluster_name" {
  type = string
  description = "The name of ECS cluster"
}

################# ASG #################
variable "asg_desired_instances" {
  type = number
  description = ""
}

variable "asg_min_instances" {
  type = number
  description = ""
}

variable "asg_max_instances" {
  type = number
  description = ""
}

################# ELB #################
variable "elb_instance_type" {
  type = string
  description = "AWS instance type of container instances."
}