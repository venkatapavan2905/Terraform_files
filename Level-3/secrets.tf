resource "aws_secretsmanager_secret" "secret" {
  name = "devops-db-password"
}

resource "aws_secretsmanager_secret_version" "version" {
  secret_id     = aws_secretsmanager_secret.secret.id
  secret_string = var.KKE_DB_PASSWORD
}

output "kke_secret_arn" {
  value = aws_secretsmanager_secret.secret.arn

}

output "kke_secret_string" {
  value = aws_secretsmanager_secret_version.version.secret_string
  sensitive = true
}

#KKE_DB_PASSWORD = "SuperSecretPassword123!"

variable "KKE_DB_PASSWORD" {
  type      = string
  sensitive = true
}