################# VPC #################
variable "vpc_private_subnet_cidr" {
  type = string
  description = "CIDR of VPC private subnet."
  default = "10.15.1.0/24"
}

variable "vpc_public_subnet_cidr" {
  type = string
  description = "CIDR of VPC public subnet."
  default = "10.15.2.0/24"
}

################# ECS #################
variable "ecs_cluster_name" {
  type = string
  description = "The name of ECS cluster"
  default = "ecs_cluster"
}

################# ASG #################
variable "asg_desired_instances" {
  type = number
  description = ""
  default = 1
}

variable "asg_min_instances" {
  type = number
  description = ""
  default = 1
}

variable "asg_max_instances" {
  type = number
  description = ""
  default = 1
}

################# ELB #################
variable "elb_instance_type" {
  type = string
  description = "AWS instance type of container instances."
  default = "t3.micro"
}