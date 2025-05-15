variable.tf
---------------------------
variable "instance_type" {
  description = "Type of the EC2 instance"
  default     = "t2.micro"
}

variable "ami_id" {
  description = "AMI ID for the instance"
  default     = " "
}

variable "region" {
  description = "AWS region to launch the instance"
  default     = "us-east-1"
}
----------------------------
terraform.tfvars
----------
ami_id    = "ami-0c55b159cbfafe1f0" # Replace with a valid AMI ID for your region
instance_type  = " "         # Replace with your actual
region         = " "
-----------------
instance.tf
----------
provider "aws" {
  region = var.region
}

resource "aws_instance" "example" {
  ami           = var.ami_id
  instance_type = var.instance_type

  tags = {
    Name = "ExampleInstance"
  }
}
-----------------------------
terraform init
terraform plan -var-file="terraform.tfvars"
terraform apply -var-file="terraform.tfvars"
----------------
runtime
--------
terraform apply -var "instance_type=t2.small" 
----------
env variable
-----------
export TF_VAR_instance_type=t2.micro

-----------------------

In Terraform, when using both a terraform.tfvars file and runtime variable passing (using -var), the order of precedence is as follows:

1.Environment Variables: Variables set as environment variables (e.g., TF_VAR_variable_name) take the highest precedence.
2.Command-Line Arguments: Variables passed directly on the command line using -var take precedence over the values in the terraform.tfvars file.
3..tfvars Files: Values specified in the terraform.tfvars file are used next.
4.Default Values: If a variable does not have a value from any of the above sources, it will fall back to its default value specified in the variables.tf file.
