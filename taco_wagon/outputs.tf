output "public_nlb_dns" {
  value       = module.web_front_end.load_balancer_dns_name
  description = "The DNS name of the public Network Load Balancer"
}