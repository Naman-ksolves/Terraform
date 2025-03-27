provider "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  region     = var.aws_region
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnet" "default" {
  vpc_id            = data.aws_vpc.default.id
  availability_zone = var.aws_availability_zone
}

resource "aws_instance" "example" {
  count             = 3
  ami               = "ami-0e35ddab05955cf57"  # Example AMI
  instance_type     = "t3.medium"
  key_name          = var.key_name
  subnet_id         = data.aws_subnet.default.id
  tags = {
    Name = "Naman-k8-${count.index + 1}"
  }
}

# Output the public and private IPs of the instances
output "instance_ips" {
  value = {
    for idx, instance in aws_instance.example :
    instance.id => {
      public_ip  = instance.public_ip
      private_ip = instance.private_ip
    }
  }
}

# Security Group for Instance 1 (X)
resource "aws_security_group" "sg_instance_1" {
  name        = "sg-instance-1"
  description = "Allow traffic from instance 2 and 3, SSH from 14.97.80.222, and specific IP"

  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = [
      "${aws_instance.example[1].public_ip}/32",  # Public IP of instance 2
      "${aws_instance.example[1].private_ip}/32", # Private IP of instance 2
      "${aws_instance.example[2].public_ip}/32",  # Public IP of instance 3
      "${aws_instance.example[2].private_ip}/32", # Private IP of instance 3
      "14.97.80.222/32"                          # Specific IP you mentioned
    ]
  }

  # SSH ingress rule for your IP
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["14.97.80.222/32"]  # Your IP for SSH access
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Security Group for Instance 2 (Y)
resource "aws_security_group" "sg_instance_2" {
  name        = "sg-instance-2"
  description = "Allow traffic from instance 1 and 3, SSH from 14.97.80.222, and specific IP"

  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = [
      "${aws_instance.example[0].public_ip}/32",  # Public IP of instance 1
      "${aws_instance.example[0].private_ip}/32", # Private IP of instance 1
      "${aws_instance.example[2].public_ip}/32",  # Public IP of instance 3
      "${aws_instance.example[2].private_ip}/32", # Private IP of instance 3
      "14.97.80.222/32"                          # Specific IP you mentioned
    ]
  }

  # SSH ingress rule for your IP
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["14.97.80.222/32"]  # Your IP for SSH access
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Security Group for Instance 3 (Z)
resource "aws_security_group" "sg_instance_3" {
  name        = "sg-instance-3"
  description = "Allow traffic from instance 1 and 2, SSH from 14.97.80.222, and specific IP"

  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = [
      "${aws_instance.example[0].public_ip}/32",  # Public IP of instance 1
      "${aws_instance.example[0].private_ip}/32", # Private IP of instance 1
      "${aws_instance.example[1].public_ip}/32",  # Public IP of instance 2
      "${aws_instance.example[1].private_ip}/32", # Private IP of instance 2
      "14.97.80.222/32"                          # Specific IP you mentioned
    ]
  }

  # SSH ingress rule for your IP
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["14.97.80.222/32"]  # Your IP for SSH access
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
