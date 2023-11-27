provider "aws" {
  region = "us-east-2"
}

resource "aws_instance" "mywebserver" {
  ami           = "ami-0e83be366243f524a" 
  instance_type = "t2.micro"
  key_name      = "ansible-ohio-key"

  tags = {
    Name = "Web-Server" 
  }
}