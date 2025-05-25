variable "aws_region" {
  default = "us-east-1"
}

variable "key_name" {
  default = "saturday"
}

variable "instance_type" {
  default = "t2.medium"
}

variable "amazon_linux_ami" {
  description = "Amazon Linux 2 AMI for us-east-1"
  default     = "ami-0c2b8ca1dad447f8a"  # As of May 2025
}

