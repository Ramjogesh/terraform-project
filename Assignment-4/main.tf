provider "aws" {
  region = "us-east-1"
}

# Create a VPC
resource "aws_vpc" "my_custom_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "MyCustomVPC"
  }
}

# Create an internet gateway and attach it to the VPC
resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_custom_vpc.id

  tags = {
    Name = "MyIGW"
  }
}

# Create a public subnet in the VPC
resource "aws_subnet" "public_subnet" {
  vpc_id     = aws_vpc.my_custom_vpc.id
  cidr_block = "10.0.1.0/24"  
  availability_zone = "us-east-1a"

  tags = {
    Name = "PublicSubnet"
  }
}

# Create a route table for the public subnet and associate it
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.my_custom_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id
  }

  tags = {
    Name = "PublicRouteTable"
  }
}

# Associate the public subnet with the public route table
resource "aws_route_table_association" "public_subnet_association" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_route_table.id
}

# Launch an EC2 instance in the public subnet
resource "aws_instance" "example_instance" {
  ami           = "ami-0fc5d935ebf8bc3bc"
  instance_type = "t2.micro" 
  key_name      = "NorthVir_APRKey"
  subnet_id     = aws_subnet.public_subnet.id
  associate_public_ip_address = true

  tags = {
    Name = "ExampleInstance"
  }
}
