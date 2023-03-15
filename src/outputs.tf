output "instance_ip" {
  value = aws_instance.test-instance.public_ip
}

output "instance_arn" {
  value = aws_instance.test-instance.arn
}
