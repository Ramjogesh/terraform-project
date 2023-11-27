provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "my_ec2_instance" {
  ami                    = "ami-0fc5d935ebf8bc3bc" 
  instance_type          = "t2.micro"             
  key_name               = "NorthVir_APRKey"  
  
  user_data = <<-EOF
              #!/bin/bash
              sudo apt-get update
              sudo apt-get install -y apache2
              sudo systemctl enable apache2
              sudo systamctl restart apache2
              PUBLIC_IP=$(curl -s http://169.254.169.254/latest/meta-data/public-ipv4)
              echo "Instance IP address: $PUBLIC_IP" > instance_ip.txt
              EOF

  tags = {
    Name = "MyEC2Instance"
  }
}

