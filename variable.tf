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
