
resource "aws_instance" "test-instance" {
  ami           = var.oregon_default_ami
  instance_type = var.freetier_instance_type

  tags = {
    "provisioner" = "terraform"
  }
}

