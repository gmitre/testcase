variable "subnet_name" {}
variable "key_name" {}
variable "aws_region" {}
variable "ec2_name" {}
variable "ec2_type" {}
variable "instance_sg_name" {}
variable "instance_sg_desc" {}
variable "instance_sg_ssh_cidr" {}
variable "elb_name" {}
variable "igw_name" {}
variable "vpc_name" {}
variable "elb_sg_name" {}
variable "elb_sg_desc" {}
variable "db_host" {}
variable "db_port" {}
variable "db_username" {}
variable "db_password" {}
variable "db_name" {}
variable "ec2_count" {}
variable "public_key_path" {}
variable "private_key_path" {}
variable "access_key" {}
variable "secret_key" {}

#Maps for AMIs x Regions
variable "aws_amis" {
  default = {
    us-west-2 = "ami-d732f0b7"
  }
}