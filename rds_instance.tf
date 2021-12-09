resource "aws_db_subnet_group" "db_subnet_group" {
  name       = var.db_subnet_group_name
  subnet_ids = [for s in aws_subnet.subnet : s.id]
}

resource "aws_db_instance" "db_instance" {
  allocated_storage       = var.db_instance_allocated_storage
  engine                  = var.db_instance_engine
  engine_version          = var.db_instance_engine_version
  instance_class          = var.db_instance_instance_class
  multi_az                = var.db_instance_multi_az
  identifier              = var.db_instance_identifier
  username                = var.db_instance_username
  password                = var.db_instance_password
  db_subnet_group_name    = aws_db_subnet_group.db_subnet_group.name
  publicly_accessible     = var.db_instance_publicly_accessible
  vpc_security_group_ids  = [aws_security_group.database.id]
  skip_final_snapshot     = var.db_instance_skip_final_snapshot
  backup_retention_period = 5
  storage_encrypted       = true
  kms_key_id              = aws_kms_key.kms_key.arn

  availability_zone = "us-east-1a"

  name                 = var.db_instance_name
  parameter_group_name = aws_db_parameter_group.db_parameter_group.name
}

resource "aws_db_instance" "db_instance_replica" {
  engine_version          = var.db_instance_engine_version
  instance_class          = var.db_instance_instance_class
  multi_az                = var.db_instance_multi_az
  identifier              = "csye6225-replica"
  db_subnet_group_name    = aws_db_subnet_group.db_subnet_group.name
  publicly_accessible     = var.db_instance_publicly_accessible
  vpc_security_group_ids  = [aws_security_group.database.id]
  skip_final_snapshot     = var.db_instance_skip_final_snapshot
  backup_retention_period = 5
  storage_encrypted       = true
  kms_key_id              = aws_kms_key.kms_key.arn

  availability_zone = "us-east-1b"

  replicate_source_db = aws_db_instance.db_instance.arn

  name                 = "csye6225-replica"
  parameter_group_name = aws_db_parameter_group.db_parameter_group.name
}