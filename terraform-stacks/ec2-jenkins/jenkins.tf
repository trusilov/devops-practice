# TERRAFORM
# Description: 
# Simple Terraform template for creating EC2 instacnes with Jenkins.

provider "aws" {}


# VARIABLES:

variable "AMI_ID" {
  description = "AMI Amazon Linux eu-central-1"
  type        = string
  default     = "ami-0a1ee2fb28fe05df3"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "Key Name"
  type        = string
  default     = "trusilov.ec2" # hardcoded 
}



# RESOURCES:

resource "aws_instance" "Jenkins" {
  ami           = var.AMI_ID
  instance_type = var.instance_type
  key_name      = var.key_name
  vpc_security_group_ids = [aws_security_group.Jenkins_SG.id]
  user_data     = "${file("UserData/init_settings.sh")}"

  tags = {
    Name = "Jenkins"
  }
}

resource "aws_security_group" "Jenkins_SG" {
  name        = "Security Group in default VPC"
  description = "Simple SG with SSH connection for EC2 in default VPC"

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Jenkins Security Group"
  }
}