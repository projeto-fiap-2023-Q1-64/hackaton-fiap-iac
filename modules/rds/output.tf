output "db_instance_endpoint" {
  description = "Endpoint de conexão para a insância do RDS"
  value = aws_db_instance.default.address
}

output "db_security_group_id" {
  description = "The ID of the database security group"
  value       = aws_security_group.db_security_group.id
}