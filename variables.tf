variable "aws_region" {
  default = "ap-south-1"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  default = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "key_name" {
  default = "tf-key"  # Replace with your actual key pair name
}

variable "instance_type" {
  default = "t2.micro"
}

variable "ami" {
  default = "ami-0a4408457f9a03be3"
}