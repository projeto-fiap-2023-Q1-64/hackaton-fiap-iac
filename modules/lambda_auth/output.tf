output "lambda_auth_invoke_arn" {
  value = aws_lambda_function.terraform_lambda_auth.invoke_arn
  description = "O ARN usado para invocar a função Lambda"
}

output "authorizer_auth_iam_role_arn" {
  value = aws_iam_role.iam_for_lambda_auth.arn
  description = "The ARN of the IAM role used for API Gateway to invoke the Lambda authorizer"
}

output "lambda_function_arn" {
  description = "The ARN of the Lambda function"
  value       = aws_lambda_function.terraform_lambda_auth.arn
}