variable "aws_ami" {
	type = string 
	description = "AWS AMI Name"
}
variable "aws_instancetype" {
	type = string 
	description = "AWS Instance Type"
}
variable "key_name" {
	type = string 
	description = "AWS SSH Key Name"
}
variable "public_key" {
	type = string 
	description = "AWS SSH Key Value"
}
variable "root_type" {
	type = string 
	description = "AWS Instance root volume type"
}
variable "root_size" {
	type = number 
	description = "AWS Instance root volume size"
}
variable "user_data" {
	type = string 
	description = "Path to user_data"
}