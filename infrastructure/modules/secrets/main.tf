resource "aws_secretsmanager_secret" "secret" {
  name_prefix             = var.name
  description             = var.description
  recovery_window_in_days = 0 # put higher or make variable usually 30 days
  tags                    = var.tags
}

#resource "aws_secretsmanager_secret_version" "example" {
#  secret_id = aws_secretsmanager_secret.example.id
#  secret_string = jsonencode({
#    username = "example-user"
#    password = "example-password"
#  })
#}
#
