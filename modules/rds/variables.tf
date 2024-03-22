variable "db_name" {
  description = "Nome do banco de dados"
  type        = string
}

variable "db_username" {
  description = "Nome de usuário do banco de dados"
  type        = string
}

variable "db_password" {
  description = "Senha do banco de dados"
  type        = string
}

variable "db_cluster_name" {
  description = "Nome do banco no rds"
  type        = string
}

variable "db_port" {
  description = "Porta do banco no rds"
  type = number
}

variable "private_subnet_1a" {}

variable "private_subnet_1b" {}

variable "eks_subnet_public_1b" {}      # remover antes da entrega, apenas para testes

variable "eks_subnet_public_1a" {}      # remover antes da entrega, apenas para testes

variable "vpc_id" {}