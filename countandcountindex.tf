resource "aws_instance" "example" {
  count         = 3  # Number of instances to create
  ami           = "ami-0f88e80871fd81e91"  # Replace with a valid AMI ID
  instance_type = "t2.micro"  # Instance type

  tags = {
    Name = "Instance-${count.index}"  # Naming instances with their index
  }

 
}

output "instance_ids" {
  value = aws_instance.example[*].id  # Output the IDs of the created instances
}