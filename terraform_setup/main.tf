provider "aws" {
  region = var.aws_region
}

resource "aws_instance" "master" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.key_name
  associate_public_ip_address = true
  subnet_id              = var.subnet_id
  tags = {
    Name = "k8s-master"
  }
}

resource "aws_instance" "worker" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.key_name
  associate_public_ip_address = true
  subnet_id              = var.subnet_id
  tags = {
    Name = "k8s-worker"
  }
}

