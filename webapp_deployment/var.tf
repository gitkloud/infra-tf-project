variable "project_name" {
  default = "folks"
  type = string
}

variable "ami_id" {
  default = "ami-07d6e46612ec5d67e"
  type = string
}

variable "key_pair" {
  default = "ops"
  type = string
}

variable "allow_cidr_range" {
  default = "0.0.0.0/0"
  type = string
}

variable "vpc_id" {
  default = "vpc-06a3014fde25f3a81"
  type = string
}
variable "instance_type" {
  default = "t2.micro"
  type = string
}

variable "environment" {
  default = "dev"
  type = string
}
variable "backend_bucket" {
  default = "pasupuleti7474"
  type = string
}
variable "backend_profile" {
  default = "default"
  type = string
}
variable "backend_region" {
  default = "us-east-1"
  type = string
}

variable "profile" {
  default = "default"
  type = string
}
variable "region" {
  default = "us-east-1"
  type = string
}