
resource "aws_instance" "test-instance" {
  ami           = var.oregon_default_ami
  instance_type = var.freetier_instance_type
  key_name      = aws_key_pair.test_instance_ssh_key.key_name
  user_data     = data.template_file.test_inst_user_data.rendered
  vpc_security_group_ids = [
    aws_security_group.test_instance_sg.id
  ]

  provisioner "remote-exec" {
    inline = [
      "echo 'test' > /tmp/testfile.txt"
    ]
    connection {
      type        = "ssh"
      user        = "ec2-user"
      host        = self.public_ip
      private_key = file("./ssh/test_instance_ssh_key")
    }
  }

  tags = {
    "provisioner" = "terraform"
  }
}

resource "aws_key_pair" "test_instance_ssh_key" {
  key_name   = "deployer"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDMMHlD78dRaVFRbRYzZOou4raU6wRXn8naAA7dFEivPOR9g3kdFakHF4MsBor1hq7CVVBpc6IwptN110ksg3g/ZZkieggIRf7XgM7tlH3wBAuv3Ob+zRaCcXhqSW01vVGFks23LdL/+nZGHMNoUoV5Ez4p84TOhYh86qQACh/dwc8NU8zC2oG9NKNBVHbUHvLXHfKcjm8vhyHxErgx1KEqz2XPKh6E9GQpUViVij4eHPLVBWZ6g3m0avtQ3QV1xi434D8WJgNnduYNcewiG1BeqSzET5vbJec+7DAFKoRKDQj112AaNkjc5GgYmUJNoApWVni77AS8RTRRzCOsVdpJ eladlevy@DESKTOP-DILUMTC"
}

data "aws_vpc" "default_vpc" {
  id = "vpc-016d7f2f9795c85e2"
}

data "template_file" "test_inst_user_data" {
  template = file("./user_data/test_instance_init.yaml")
}

resource "aws_security_group" "test_instance_sg" {
  name        = "http_server_sg"
  description = "Allow http from anywhere and ssh from deployer"
  vpc_id      = data.aws_vpc.default_vpc.id

  ingress = [{
    description      = "SSH from my IP"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["147.235.204.79/32"]
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    security_groups  = []
    self             = false
    }, {

    description      = "HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    security_groups  = []
    self             = false
  }]

  egress = [{
    description      = "Allow all outgoing traffic"
    prefix_list_ids  = []
    security_groups  = []
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = []
    self             = false
  }]

  tags = {
    "provisioner" = "terraform"
  }

}