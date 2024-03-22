variable "lambda_name" {}

variable "db_endpoint" {
  description = "Endpoint para conexão com o banco"
  type = string
}

variable "db_username" {
  description = "Endpoint para conexão com o banco"
  type = string
}

variable "db_password" {
  description = "Endpoint para conexão com o banco"
  type = string
}

variable "db_port" {
  description = "Endpoint para conexão com o banco"
  type = string
}

variable "db_database" {
  description = "Endpoint para conexão com o banco"
  type = string
}

variable "jwt_secret" {
  description = "Endpoint para conexão com o banco"
  type = string
}

variable "db_security_group_id" {}

variable "private_subnet_1a" {}

variable "private_subnet_1b" {}