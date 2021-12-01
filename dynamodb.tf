resource "aws_dynamodb_table" "dynamodb-table" {
  name           = "User-Tokens"
  read_capacity  = 20
  write_capacity = 20
  hash_key       = "user_email"

  attribute {
    name = "user_email"
    type = "S"
  }

  ttl {
    attribute_name = "expirationTime"
    enabled        = true
  }

  tags = {
    Name        = "dynamodb-table"
    Environment = "prod"
  }
}