terraform {
  backend "s3" {
    bucket = "cloud-journey-state-vivekvardhan" # enter the bucket name without mistake
    key    = "terraform.tfstate"
    region = "ap-south-1"
  }
}

provider "aws" {
  region = "ap-south-1"
}

# 1. The Firewall (Security Group)
# Allow everyone to see the website (Port 80) and you to SSH (Port 22)
resource "aws_security_group" "web_firewall" {
  name        = "allow_web_traffic"
  description = "Allow HTTP and SSH"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
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
}

# 2. The Server (EC2 Instance)
resource "aws_instance" "my_server" {
  ami           = "ami-00bb6a80f01f03502" # Ubuntu 24.04 in Mumbai
  instance_type = "t3.micro"              # Free Tier
  key_name      = "CloudKey"              # The key made yesterday
  security_groups = [aws_security_group.web_firewall.name]

  # This script runs ONCE when the server starts
  user_data = <<-EOF
              #!/bin/bash
              # Update and install Docker & Git
              sudo apt update -y
              sudo apt install -y docker.io git
              
              # Start Docker
              sudo systemctl start docker
              sudo systemctl enable docker
              
              # Download code from GitHub
              git clone https://github.com/Keviv123/cloud-journey.git /home/ubuntu/app
              
              # Build and Run the Container
              cd /home/ubuntu/app
              sudo docker build -t cloud-resume .
              sudo docker run -d -p 80:80 cloud-resume
              EOF

  tags = {
    Name = "Cloud-Resume-Server"
  }
}

# 3. Output the IP Address so it can be found
output "public_ip" {
  value = aws_instance.my_server.public_ip
}
