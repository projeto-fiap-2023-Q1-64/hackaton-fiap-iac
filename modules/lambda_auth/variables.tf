variable "lambda_name" {}

variable "jwt_secret" {
  description = "Endpoint para conexão com o banco"
  type = string
}

variable "db_security_group_id" {}

variable "private_subnet_1a" {}

variable "private_subnet_1b" {}