variable "instance_names" {
  type    = list(string)
  default = ["AppServer-01", "AppServer-02", "AppServer-03"]  # Add as many names as needed
}

resource "aws_instance" "example1" {
  count         = length(var.instance_names)  # Create instances based on the length of the names list
  ami           = "ami-0f88e80871fd81e91"  # Replace with a valid AMI ID
  instance_type = "t2.micro"  # Instance type

  tags = {
    Name = var.instance_names[count.index]  # Unique name from the list
  }
}

output "instance_names" {
  value = aws_instance.example1[*].id  # Output the IDs of the created instances
}