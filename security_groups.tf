# Security Group for the Bastion Host
resource "aws_security_group" "bastion_sg" {
  name        = "my-bastion-sg"
  vpc_id      = aws_vpc.my_vpc.id

  ingress {
    description = "Allow SSH from anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "my-bastion-sg"
  }
}

# Security Group for the Web Servers in the Private Subnet
resource "aws_security_group" "web_sg" {
  name        = "my-web-sg"
  vpc_id      = aws_vpc.my_vpc.id

  # Ingress rule to allow HTTP traffic from the ALB
  ingress {
    description = "Allow HTTP from ALB"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    security_groups = [aws_security_group.alb_sg.id]
  }

  # Ingress rule to allow SSH traffic from the Bastion Host
  ingress {
    description = "Allow SSH from Bastion Host"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    security_groups = [aws_security_group.bastion_sg.id]
  }

  # Egress rule to allow outbound traffic through the NAT Gateway
  egress {
    description = "Allow outbound traffic via NAT Gateway"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "my-web-sg"
  }
}

# Security Group for the ALB
resource "aws_security_group" "alb_sg" {
  name        = "my-alb-sg"
  vpc_id      = aws_vpc.my_vpc.id

  ingress {
    description = "Allow HTTP traffic from the Internet"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "my-alb-sg"
  }
}