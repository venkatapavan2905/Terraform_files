resource "aws_kms_key" "xfusion_kms_key" {
  description             = "KMS key for encrypting and decrypting sensitive data"
  deletion_window_in_days = 7
  enable_key_rotation     = true
  tags = {
    Name = "xfusion-kms-key"
  }
}

data "local_file" "sensitive_file" {
  filename = "/home/bob/terraform/SensitiveData.txt"
}

resource "aws_kms_ciphertext" "encrypted_file" {
  key_id = aws_kms_key.xfusion_kms_key.key_id
  plaintext = data.local_file.sensitive_file.content
}

# Save encrypted output (base64) to a file
resource "local_file" "encrypted_data" {
  filename = "/home/bob/terraform/EncryptedData.bin"
  content  = aws_kms_ciphertext.encrypted_file.ciphertext_blob
}

data "aws_kms_secrets" "decrypted_file" {
  secret {
    name    = "decrypted"
    payload = aws_kms_ciphertext.encrypted_file.ciphertext_blob
  }
}

resource "local_file" "decrypted_data" {
  filename = "/home/bob/terraform/DecryptedData.txt"
  content  = data.aws_kms_secrets.decrypted_file.plaintext["decrypted"]
}