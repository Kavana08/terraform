Consistency: Use modules to standardize how resources are set up across different projects (e.g., EC2 instances, VPCs).

Reuse: Create a module for common resources (like a web server) and use it in multiple places without rewriting code.

Simplify Complexity: Hide complicated setups behind a simple module, so users can easily deploy without needing to know all the details.

Environment Variations: Use variables in modules to customize configurations for different environments (dev, staging, production).

Collaboration: Different teams can work on separate modules without stepping on each other’s toes, promoting teamwork.

Testing: Easily test individual modules in isolation before deploying them as part of a larger system.


Directory Structure

terraform-ec2-module/
├── main.tf
├── variables.tf
├── outputs.tf

main.tf
This file defines the EC2 instance resource.

provider "aws" {
  region = var.region
}

resource "aws_instance" "example" {
  ami           = var.ami
  instance_type = var.instance_type

  tags = {
    Name = var.instance_name
  }
}
variables.tf
This file defines the required input variables.

variable "region" {
  description = "The AWS region to deploy the EC2 instance."
  type        = string
}

variable "ami" {
  description = "The AMI ID for the instance."
  type        = string
}

variable "instance_type" {
  description = "The type of instance to create."
  type        = string
}

variable "instance_name" {
  description = "The name of the instance."
  type        = string
}
outputs.tf
This file defines the outputs for the module.


output "instance_id" {
  description = "The ID of the created EC2 instance."
  value       = aws_instance.example.id
}

output "instance_public_ip" {
  description = "The public IP of the created EC2 instance."
  value       = aws_instance.example.public_ip
}

Usage
To use the module in your Terraform configuration, you can reference it like this:


module "ec2_instance" {
  source        = "./terraform-ec2-module"
  region        = "us-east-1"
  ami           = "ami-0c55b159cbfafe01e"  # Replace with a valid AMI ID
  instance_type = "t2.micro"
  instance_name = "MyEC2Instance"
}

output "instance_id" {
  value = module.ec2_instance.instance_id
}

output "instance_public_ip" {
  value = module.ec2_instance.instance_public_ip
}
