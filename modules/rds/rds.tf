resource "aws_db_subnet_group" "default" {
  name       = "main"

  subnet_ids = [

      var.private_subnet_1a, 
      var.private_subnet_1b
  ]

  tags = { 
    Name = "DB subnet group"
  }
}

resource "aws_security_group" "db_security_group" {
  name        = "db-security-group"
  description = "Security group for RDS instance"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = var.db_port
    to_port     = var.db_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = var.db_port
    to_port     = var.db_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "db-security-group"
  }
}

resource "aws_db_instance" "default" {
  identifier = var.db_cluster_name
  allocated_storage    = 10
  db_name              = var.db_name
  engine               = "postgres"
  engine_version       = "15.3"
  instance_class       = "db.t3.micro"
  username             = var.db_username
  password             = var.db_password
  parameter_group_name = "default.postgres15"
  skip_final_snapshot  = true
  db_subnet_group_name = aws_db_subnet_group.default.name

  vpc_security_group_ids = [aws_security_group.db_security_group.id]

  timeouts {
    delete = "30m"
  }
}