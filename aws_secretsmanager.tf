resource "aws_secretsmanager_secret" "xfusion-secret" {
    name = "xfusion-secret"
}

resource "aws_secretsmanager_secret_version" "version" {
    secret_id = aws_secretsmanager_secret.xfusion-secret.id
    secret_string = jsonencode({
        username = "admin"
        password = "Namin123"
    })
}