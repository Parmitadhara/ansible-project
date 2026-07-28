variable "region" {
  default = "ap-south-1"
}

variable "instance_type" {
  default = "t3.micro"
}

variable "key_name" {
  description = "Existing AWS Key Pair Name"
}

variable "ami_id" {
  description = "Amazon Linux 2023 AMI"
}