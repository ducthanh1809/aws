terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
  required_version = ">= 1.2.0"
}

provider "aws" {
  region  = var.region
  access_key = var.access_key
  secret_key = var.secret_key
}

module "vm_provisioning" {
  source = "../modules/ec2"
  aws_ami = var.aws_ami
  aws_instancetype = var.aws_instancetype
  key_name = var.key_name
  public_key = var.public_key
  root_type = var.root_type
  root_size = var.root_size
  user_data = var.user_data[var.user_input]
}

data "aws_instance" "ec2_instance" {
  instance_id = module.vm_provisioning.instance_id
}
resource "aws_ebs_volume" "additional_volume" {
  availability_zone = data.aws_instance.ec2_instance.availability_zone
  size              = 1
  type              = "gp2"
}
resource "aws_volume_attachment" "ebs_att" {
  device_name = "/dev/sdb"
  volume_id   = aws_ebs_volume.additional_volume.id
  instance_id = data.aws_instance.ec2_instance.instance_id
}
output "PublicIP" {
  description = "Public IP address of the EC2 instance"
  value       = module.vm_provisioning.PublicIP
}
