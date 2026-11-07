
output "web_instance_ids" {
  value = aws_instance.web[*].id
}

output "app_instance_ids" {
  value = aws_instance.app[*].id
}

output "database_instance_id" {
  value = aws_instance.database.id
}

output "web_private_ips" {
  value = aws_instance.web[*].private_ip
}

output "app_private_ips" {
  value = aws_instance.app[*].private_ip
}

output "database_private_ip" {
  value = aws_instance.database.private_ip
}
