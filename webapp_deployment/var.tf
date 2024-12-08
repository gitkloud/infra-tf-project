variable "project_name" {
  default = "folks"
  type = string
}

variable "ami_id" {
  default = "ami-123"
  type = string
}

variable "key_pair" {
  default = "all-purpose-server-key"
  type = string
}

variable "allow_cidr_range" {
  default = "0.0.0.0/0"
  type = string
}

variable "vpc_id" {
  default = "vpc-017981d0907d9a5b3"
  type = string
}