variable "cidr" {
  default = "11.0.0.0/16"
}

resource "aws_vpc" "myvpc1" {
  cidr_block = var.cidr
  tags = {
    name="VS-VPC"
  }
}

resource "aws_subnet" "sub1" {
  vpc_id                  = aws_vpc.myvpc1.id
  cidr_block              = "11.0.0.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    name="pub-subnet1"
  }
}

resource "aws_subnet" "sub2" {
  vpc_id                  = aws_vpc.myvpc1.id
  cidr_block              = "11.0.1.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true
  tags = {
    name="pri-subnet1"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.myvpc1.id
  tags = {
    name="vpc-igw1"
  }
}

resource "aws_route_table" "RT" {
  vpc_id = aws_vpc.myvpc1.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
    
  }
}

resource "aws_route_table_association" "rta1" {
  subnet_id      = aws_subnet.sub1.id
  route_table_id = aws_route_table.RT.id
}

resource "aws_route_table_association" "rta2" {
  subnet_id      = aws_subnet.sub2.id
  route_table_id = aws_route_table.RT.id
}

resource "aws_security_group" "webSg" {
  name   = "web"
  vpc_id = aws_vpc.myvpc1.id

  ingress {
    description = "HTTP from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "SSH"
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
    Name = "Web-sg"
  }
}


resource "aws_instance" "webserver1" {
  ami                    = "ami-0f88e80871fd81e91"
  instance_type          = "t2.micro"
  key_name               = "privatekey"
  vpc_security_group_ids = [aws_security_group.webSg.id]
  subnet_id              = aws_subnet.sub1.id
  associate_public_ip_address = true
  tags = {
    name="public instance"
  }
}

resource "aws_instance" "webserver2" {
  ami                    = "ami-0f88e80871fd81e91"
  instance_type          = "t2.micro"
   key_name               = "privatekey"
  vpc_security_group_ids = [aws_security_group.webSg.id]
  subnet_id              = aws_subnet.sub2.id
  associate_public_ip_address = false

  tags={
    name= "private instance"
  }

}


