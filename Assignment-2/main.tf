provider "aws" {
  region = "us-east-2"
}

resource "aws_instance" "example" {
  ami           = "ami-0e83be366243f524a"
  instance_type = "t2.micro"
  key_name      = "ansible-ohio-key"

  tags = {
    Name = "ExampleInstance"
  }
}

resource "aws_eip" "example" {
  instance = aws_instance.example.id
}

output "elastic_ip" {
  value = aws_eip.example.public_ip
}