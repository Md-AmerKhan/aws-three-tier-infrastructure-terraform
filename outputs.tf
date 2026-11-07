
output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_alb_dns_name" {
  value = module.load_balancers.public_alb_dns_name
}

output "private_alb_dns_name" {
  value = module.load_balancers.private_alb_dns_name
}

output "web_instance_private_ips" {
  value = module.compute.web_private_ips
}

output "app_instance_private_ips" {
  value = module.compute.app_private_ips
}

output "database_private_ip" {
  value = module.compute.database_private_ip
}
