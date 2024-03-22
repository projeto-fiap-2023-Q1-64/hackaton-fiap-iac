resource "aws_lambda_function" "terraform_lambda_auth" {
  function_name = var.lambda_name

  filename = "deployment_auth.zip"

  handler = "index.handler"
  role    = "${aws_iam_role.iam_for_lambda_auth.arn}"
  runtime = "nodejs18.x"

  environment {
    variables = {
      JWT_SECRET = var.jwt_secret
    }
  }

  vpc_config {
    subnet_ids = [
        var.private_subnet_1a, 
        var.private_subnet_1b
    ]
    security_group_ids = [var.db_security_group_id]
  }

}

resource "aws_iam_role" "iam_for_lambda_auth" {
  name = "iam_for_lambda_auth"

  assume_role_policy = jsonencode({
  Version: "2012-10-17",
  Statement: [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
  })
}

resource "aws_iam_role_policy" "lambda_vpc_access" {
  name   = "LambdaVPCAccess"
  role   = aws_iam_role.iam_for_lambda_auth.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect    = "Allow",
        Action    = [
          "ec2:CreateNetworkInterface",
          "ec2:DescribeNetworkInterfaces",
          "ec2:DeleteNetworkInterface",
        ],
        Resource = "*"
      },
    ]
  })
}