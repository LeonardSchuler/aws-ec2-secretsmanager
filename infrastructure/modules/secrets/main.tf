resource "aws_secretsmanager_secret" "secret" {
  name_prefix             = var.name
  description             = var.description
  recovery_window_in_days = 0 # put higher or make variable usually 30 days
  tags                    = var.tags
}
