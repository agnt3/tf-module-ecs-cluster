output "ecs_cluster_arn" {
  value = aws_ecs_cluster.ecs_cluster.arn
}

output "vpc_id" {
  value = aws_vpc.cluster_vpc.id
}

output "lb_arn" {
  value = aws_lb.cluster_load_balancer.arn
}

output "lb_dns" {
  value = aws_lb.cluster_load_balancer.dns_name
}