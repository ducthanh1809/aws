terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
  required_version = ">= 1.2.0"
}
resource "aws_security_group" "public" {
  name = "public-access"
  description = "Public internet access"
 
  tags = {
    Role        = "public"
    ManagedBy   = "terraform"
  }
}

resource "aws_key_pair" "deployer" {
  key_name   = var.key_name
  public_key = var.public_key
}

resource "aws_security_group_rule" "public_out" {
  type        = "egress"
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = aws_security_group.public.id
}
resource "aws_security_group_rule" "public_in_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.public.id
}
resource "aws_instance" "app_server" {
  ami = var.aws_ami
  instance_type = var.aws_instancetype
  key_name = "${aws_key_pair.deployer.key_name}"
  root_block_device {
    volume_size = var.root_size
    volume_type = var.root_type
  }
  tags = {
	Name = "Terraform Instance"
  }
  user_data = "${file(var.user_data)}"
}
resource "aws_network_interface_sg_attachment" "sg_attachment" {
  security_group_id    = "${aws_security_group.public.id}"
  network_interface_id = "${aws_instance.app_server.primary_network_interface_id}"
}
output "instance_id" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.app_server.id
}
output "PublicIP" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.app_server.public_ip
}