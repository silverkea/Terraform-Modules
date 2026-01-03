output "autoscaling_group_name" {
  description = "The name of the Autoscaling Group"
  value       = aws_autoscaling_group.front_end.name
}

output "load_balancer_dns_name" {
  description = "The DNS name of the Load Balancer"
  value       = aws_lb.front_end.dns_name
}