variable "region" {
	type = string 
	description = "AWS Region"
}
variable "access_key" {
	type = string 
	description = "AWS Access Key"
}
variable "secret_key" {
	type = string 
	description = "AWS Secret Key"
}
variable "aws_ami" {
	type = string 
	default = "ami-0a481e6d13af82399"
	description = "AWS AMI Name"
}
variable "aws_instancetype" {
	type = string
	default = "t2.micro"
	description = "AWS Instance Type"
}
variable "key_name" {
	type = string
    default = "terrformSSH"	
	description = "terrformSSH"
}
variable "public_key" {
	type = string
	default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDaHb6v1MmG9Vc0YwTcQtbGYd5UFsdKZjq6wwNmi29RdFQRyvcDj3LIMvp8KX4gYbUmpfAgDjkRz6YVGkEAcC9wBawk4wfNrUD8bT7NzJCsE2kQQAIjrqs7LotabFAKlArkL+sEH/UlTyyRvaflvilf+osVD+oKcx2tVlTGK2+YTmoDJddsMjIz2MIk0kV5rM5/gr06iV7/JalcOjFNAbkfd9VEX7rDVHLVMaVLybqOgjg2aWrKiFsA2cn4ISih3CxbQWGLQN6Td0zhiaYx6P/B+twH78HQputbGGuDxi168BMB8LUSZrTdlBlQi6bKapKWI9kIt2PJD3PXeCz/f4N9 ancenter@vnpaydrp101.novalocal"
	description = "AWS SSH Key Value"
}
variable "root_type" {
	type = string
	default = "gp2"
	description = "AWS Instance root volume type"
}
variable "root_size" {
	type = number
	default = 10
	description = "AWS Instance root volume size"
}
variable "user_data" {
	type = map(string)
	description = "AWS User Data Script"
	default = {
	"default"="../user-data/init_ping.sh"
	"interview"= "../user-data/init_interview.sh"
	"httpd"= "../user-data/init_httpd.sh"
	}
}
variable "user_input" {
	type = string
	description = "Input for userdata"
	default = "default"
	validation {
	  condition = var.user_input == "interview" || var.user_input == "httpd" || var.user_input == "default"
	  error_message = "not support" 
	}
}