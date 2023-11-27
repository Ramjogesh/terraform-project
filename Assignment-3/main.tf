provider "aws" {
  alias  = "us_east_2"
  region = "us-east-2"
}


resource "aws_instance" "hello_ohio" {
  provider      = aws.us_east_2
  ami           = "ami-0e83be366243f524a"
  instance_type = "t2.micro" 
  key_name      = "ansible-ohio-key"

  tags = {
    Name = "hello-ohio"
  }
}

provider "aws" {
  alias  = "us_east_1" 
  region = "us-east-1" 
}

resource "aws_instance" "hello_virginia" {
  provider      = aws.us_east_1
  ami           = "ami-0fc5d935ebf8bc3bc" 
  instance_type = "t2.micro" 
  key_name      = "NorthVir_APRKey"

  tags = {
    Name = "hello-virginia" 
  }
}
