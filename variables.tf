################# VPC #################
variable "vpc_cidr" {
  type = string
}

variable "vpc_private_subnet_az" {
  type = string
  description = "Availability Zone that private subnet will be created."
}

variable "vpc_public_subnet_az" {
  type = list(string)
  description = "Availability Zone that public subnet will be created."
}

variable "vpc_private_subnet_cidr" {
  type = string
  default = "10.0.1.0/24"
  description = "CIDR of VPC private subnet."
}

variable "vpc_public_subnet_cidr" {
  type        = list(string)
  default     = ["10.0.2.0/24", "10.0.3.0/24"]
  description = "CIDR of VPC public subnet."
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

variable "launch_template_instance_type" {
  type = string
}