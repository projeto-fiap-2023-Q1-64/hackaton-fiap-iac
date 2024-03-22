module "network" {
  source = "./modules/network"

  cluster_name = var.cluster_name
  region = var.region
}

module "rds" {
  source = "./modules/rds"

  private_subnet_1a = module.network.private_subnet_1a
  private_subnet_1b = module.network.private_subnet_1b
  eks_subnet_public_1b = module.network.eks_subnet_public_1b
  eks_subnet_public_1a = module.network.eks_subnet_public_1a
  vpc_id = module.network.vpc_id

  db_cluster_name = var.db_cluster_name
  db_name = var.db_name
  db_username = var.db_username
  db_password = var.db_password
  db_port = var.db_port
}

module "master" {
  source = "./modules/master"

  cluster_name = var.cluster_name
  kubernetes_version = var.kubernetes_version

  private_subnet_1a = module.network.private_subnet_1a
  private_subnet_1b = module.network.private_subnet_1b
}

module "node" {
  source = "./modules/node"

  cluster_name = module.master.cluster_name

  private_subnet_1a = module.network.private_subnet_1a
  private_subnet_1b = module.network.private_subnet_1b

  desired_size = var.desired_size
  min_size = var.min_size
  max_size = var.max_size

}

module "lambda_jwt" {
  source = "./modules/lambda_jwt"

  lambda_name = var.lambda_jwt_name
  db_endpoint = module.rds.db_instance_endpoint
  db_username = var.db_username
  db_password = var.db_password
  db_port = var.db_port
  db_database = var.db_name
  jwt_secret = var.jwt_secret

  db_security_group_id = module.rds.db_security_group_id
  private_subnet_1a = module.network.private_subnet_1a
  private_subnet_1b = module.network.private_subnet_1b

}

module "lambda_auth" {
  source = "./modules/lambda_auth"

  lambda_name = var.lambda_auth_name
  jwt_secret = var.jwt_secret

  db_security_group_id = module.rds.db_security_group_id
  private_subnet_1a = module.network.private_subnet_1a
  private_subnet_1b = module.network.private_subnet_1b
}

module "kubernetes_nlb" {
  source = "./modules/kubernetes_nlb"

  cluster_name = module.master.cluster_name
  region = var.region
}

module "api_gateway" {
  source = "./modules/api-gateway"

  nlb_wait_trigger = module.kubernetes_nlb.wait_for_nlb_trigger
  nlb_arn = module.kubernetes_nlb.nlb_arn
  nlb_dns_name = module.kubernetes_nlb.nlb_dns_name

  lambda_invoke_arn = module.lambda_jwt.lambda_invoke_arn
  lambda_role_arn   = module.lambda_jwt.authorizer_iam_role_arn
  lambda_function_jwt_arn  = module.lambda_jwt.lambda_function_arn

  lambda_auth_invoke_arn = module.lambda_auth.lambda_auth_invoke_arn
  lambda_auth_role_arn = module.lambda_auth.authorizer_auth_iam_role_arn
  lambda_function_auth_arn  = module.lambda_auth.lambda_function_arn

  lambda_auth_name = var.lambda_auth_name
  lambda_jwt_name = var.lambda_jwt_name
}