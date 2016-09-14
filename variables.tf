variable "vpc_name" { 
  default = "guilherme-mitre-PROJECT-ENV"
}

variable "igw_name" { 
  default = "guilherme-mitre-PROJECT-ENV"
}

variable "subnet_name" { 
  default = "guilherme-mitre-PROJECT-ENV"
}

variable "elb_sg_name" { 
  default = "guilherme-mitre-PROJECT-ENV-SG-ELB"
}

variable "elb_sg_desc" { 
  default = "ELB Security Group for Guilherme Mitre PROJECT ENV"
}

variable "instance_sg_name" { 
  default = "guilherme-mitre-PROJECT-ENV-SG-EC2"
}

variable "instance_sg_desc" { 
  default = "EC2 Security Group for Guilherme Mitre PROJECT ENV"
}

variable "instance_sg_ssh_cidr" { 
  default = "0.0.0.0/0"
}

variable "elb_name" {
  default = "guilherme-mitre-project-env"
}

variable "ec2_type" {
  default = "t2.micro"
}

variable "ec2_count" {
  default = "2"
}

variable "ec2_name" {
  default = "guilherme-mitre-project-env"
}

variable "public_key_path" {
	default = "~/.ssh/id_rsa"
}

variable "private_key_path" {
	default = "~/.ssh/id_rsa.pub"
}

variable "key_name" {
 	description = "Desired name of AWS key pair"
	default = "Guilherme-Mitre KEY"
}

variable "aws_region" {
  description = "AWS region to launch servers."
  default = "us-west-2"
}

variable "aws_amis" {
  default = {
    eu-west-1 = "ami-b1cf19c6"
    us-east-1 = "ami-de7ab6b6"
    us-west-1 = "ami-3f75767a"
    us-west-2 = "ami-d732f0b7"
  }
}