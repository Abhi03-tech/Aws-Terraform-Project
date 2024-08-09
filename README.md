# Title: Automated Aws Infrastructure Setup With terraform
In this project, we will setup a fully automated & secure infrastructure on aws using terraform.

# Project Overview
## Project Overview

This project demonstrates an automated setup of a scalable and secure AWS infrastructure using Terraform. It includes the creation of a Virtual Private Cloud (VPC), public and private subnets, an Internet Gateway (IGW), a NAT Gateway, Auto Scaling Groups (ASG), an Application Load Balancer (ALB), and a Bastion Host for secure SSH access.

The setup ensures that servers hosted in private subnets can access the internet securely via NAT, while clients connect to the service through an ALB. This infrastructure is designed for high availability, scalability, and security.

# Architecture Diagram
![VPC Project](https://github.com/user-attachments/assets/3684c48a-d642-4bd1-ad65-e4480fa9f325)


# Prerequisite
1. An Aws account
2. Aws Cli on the local system
3. VS code editor
4. Intermediate level knowledge of Aws, Terraform & Networking

# Setup the Working Environment

# 1. Login into Aws account and create an IAM user
Click on users
![1](https://github.com/user-attachments/assets/974b970c-8eb8-4ebc-bead-1f98b229ac78)


### Select create user

![2](https://github.com/user-attachments/assets/3e61bab8-b4da-45ac-83e6-e0207ed93bda)


### Give a username & click next

![3](https://github.com/user-attachments/assets/7eb5067a-b9f4-4a66-aa8a-4a6add1196bb)


### Select permissions

![4](https://github.com/user-attachments/assets/060820fa-d049-46b5-8977-004965ba12b4)


### Select AdministratorAccess

![5](https://github.com/user-attachments/assets/b4b21ea0-83d1-4b53-9781-e8df5c791d4a)


### Select Create user

![6](https://github.com/user-attachments/assets/7be9bfb2-8848-4a2b-886f-66d5e20c2b1c)


### Now, Click on Create access key

![7](https://github.com/user-attachments/assets/6fec1cff-9029-4af7-8c8c-fb268e97cb05)


### Select any suitable use-case

![8](https://github.com/user-attachments/assets/bc0faba3-526e-4796-966f-b697b8a502b5)


### Select the Checkbox & then next

![9](https://github.com/user-attachments/assets/c54e267a-02bc-40cc-9e83-f3de5ad41378)


### Description is optional. Create access key.

![10](https://github.com/user-attachments/assets/9975a714-a935-4bb1-a020-7dbbdd0166a3)


### Download the csv file for future references

![11](https://github.com/user-attachments/assets/a4b02935-49ec-4d86-870f-bf27f7fc4148)


### As, Aws Cli should be installed on the local system.
### Now, open cmd (i am using windows) and run the command "aws configure --profile terraform". this will create a profile locally in .aws directory, that stores the credentials.

### just copy the access key & secret access key of iam user & paste. select a desired region & output format.

![12](https://github.com/user-attachments/assets/d3563cff-91c8-42f4-81a3-a0fd2e2c3feb)


### Change the directory to .aws & see the available files there.

![13](https://github.com/user-attachments/assets/ae9ae7ba-5f2a-46e5-80c8-aea42f0968ef)


### Open the credentials file using notepad or any other terminal. cmd **notepad credentials**

![14](https://github.com/user-attachments/assets/53ba14a9-7ab4-4715-83eb-2b4a12f5cd9d)

## Setup the Profile in VS Code.


### Now, create a project directory and open it in VS code.

### before jumping into writing the configuration files for our project, complete some prerequisite like let our vs code know where our credentials are saved. so, we don't have to put our credentials in conf. file.

### Click on Extensions & install AWS Toolkit. In my case, it's installed.

![15](https://github.com/user-attachments/assets/ca0cceb7-8872-416a-9c07-c665404d7e66)


### Click on View & then Open View

![16](https://github.com/user-attachments/assets/0c327dfe-2b90-4a11-a4de-0f0fd4ab7193)


### Select the option AWS

![17](https://github.com/user-attachments/assets/d11baeb6-40f0-4ab0-afb2-2d03caf988bb)


### Right now vs code is connected with default profile, click on that.

![18](https://github.com/user-attachments/assets/c8e81b2b-a519-49ed-85e9-2d2d5f47f286)


### Before terraform profile, there's is X sign means it's not authenticated by VS code till now. Click on that profile.

![19](https://github.com/user-attachments/assets/72f3d316-9395-4ee1-add1-e0801e927129)


### Now, profile terraform is connected with Vs code editor & it's in use.

![21](https://github.com/user-attachments/assets/5ad51583-9060-4c3b-802b-a16fb574e22f)


### Working Environment is now ready.

### Now, we move towards writing the configuration file for our project. Here, we will break every AWS resource in different configuration files instead of writing all the codes in main.tf file. It will help us to document our project better.


# main.tf
### Here, we will provide details about provider.
```hcl
provider "aws" {
  region = var.aws_region
}
```
### Explanation
**provider "aws"**: Configures the AWS provider and specifies the region to deploy resources.

**region = var.aws_region**: Uses the aws_region variable defined in variables.tf to set the AWS region.

# variables.tf
```hcl
variable "aws_region" {
  default = "ap-south-1"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  default = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "key_name" {
  default = "tf-key"  # Replace with your actual key pair name
}

variable "instance_type" {
  default = "t2.micro"
}

variable "ami" {
  default = "ami-0a4408457f9a03be3"
}
```
## Explanation

### variable "aws_region": Defines the AWS region to deploy resources.
default: Sets the default value to us-west-2.

### variable "vpc_cidr": Defines the CIDR block for the VPC.
default: Sets the default CIDR block to 10.0.0.0/16.

### variable "public_subnet_cidrs": Defines the CIDR blocks for the public subnets.
default: Sets the default CIDR blocks to ["10.0.1.0/24", "10.0.2.0/24"].

### variable "private_subnet_cidrs": Defines the CIDR blocks for the private subnets.
default: Sets the default CIDR blocks to ["10.0.3.0/24", "10.0.4.0/24"].

### variable "key_name": Defines the name of the SSH key pair to use for instances.
default: Sets the default key name to your-key-name.

### variable "instance_type": Defines the instance type to be used.
default: Sets the default instance i.e. t2.micro

**variable "ami": Defines the ami(amazon machine image)**.

default: Sets the default Ami value

# vpc.tf
```hcl
resource "aws_vpc" "my_vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "my-vpc"
  }
}
```

## Explanation
**resource "aws_vpc" "my_vpc": Creates a VPC**.

**cidr_block**: Sets the CIDR block for the VPC using the vpc_cidr variable.

**tags**: Adds a tag to the VPC with the name "my-vpc".

# subnets.tf

**Here, we create 2 public & 2 private subnets in vpc my-vpc**

```hcl
data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_subnet" "public_subnet" {
  count = length(var.public_subnet_cidrs)

  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = element(var.public_subnet_cidrs, count.index)
  map_public_ip_on_launch = true
  availability_zone       = element(data.aws_availability_zones.available.names, count.index)

  tags = {
    Name = "my-public-subnet-${count.index + 1}"
  }
}

resource "aws_subnet" "private_subnet" {
  count = length(var.private_subnet_cidrs)

  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = element(var.private_subnet_cidrs, count.index)
  map_public_ip_on_launch = false
  availability_zone = element(data.aws_availability_zones.available.names, count.index)

  tags = {
    Name = "my-private-subnet-${count.index + 1}"
  }
}
```

### Explanation
**resource "aws_subnet" "public_subnet"**: Creates public subnets.

**count**: Creates multiple subnets based on the number of CIDR blocks defined in public_subnet_cidrs.

**vpc_id**: Associates the subnet with the VPC created in vpc.tf.

**cidr_block**: Sets the CIDR block for each subnet using the public_subnet_cidrs variable.

**map_public_ip_on_launch**: Automatically assigns a public IP address to instances launched in the subnet.

**tags**: Adds a tag to each subnet with a name that includes the index.

**resource "aws_subnet" "private_subnet"**: Creates private subnets.

# internet_gateway.tf

**Internet gateway helps clients over internet to come & connect to local server & server to go over the internet.**

```hcl
resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "my-igw"
  }
}
```
### Explanation
**resource "aws_internet_gateway" "my_igw"**: Creates an Internet Gateway.

**vpc_id**: Associates the Internet Gateway with the VPC created in vpc.tf.

**tags**: Adds a tag to the Internet Gateway with the name "my-igw".


# nat_gateway.tf

**Nat gateway helps servers in private subnet to go over internet. private subnets don't have public ips and these servers send request to nat gateway, nat masks the server ip and using its own public ip it send the server over internet.**

```hcl
resource "aws_eip" "nat_eip" {
  count = length(var.private_subnet_cidrs)
  domain = "vpc"

  tags = {
    Name = "my-nat-eip-${count.index + 1}"
  }
}

resource "aws_nat_gateway" "my_natgw" {
  count         = length(var.private_subnet_cidrs)
  allocation_id = aws_eip.nat_eip[count.index].id
  subnet_id     = element(aws_subnet.public_subnet.*.id, count.index)

  tags = {
    Name = "my-nat-gw-${count.index + 1}"
  }
}
```

### Explanation
**resource "aws_eip" "nat_eip"**: Creates Elastic IP addresses for the NAT Gateways.

**count**: Creates multiple Elastic IPs based on the number of public subnets.

**resource "aws_nat_gateway" "my_natgw"**: Creates NAT Gateways.

**count**: Creates multiple NAT Gateways based on the number of public subnets.

**allocation_id**: Associates the NAT Gateway with the Elastic IP.

**subnet_id**: Associates the NAT Gateway with the corresponding public subnet.

**tags**: Adds a tag to each NAT Gateway with a name that includes the index.



# route_tables.tf

**public_rt will be connected with public subnets and associate the route to igw & private_rt will connect with private subnets and route will be associated with nat gw**

```hcl
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id
  }

  tags = {
    Name = "public-rt"
  }
}

resource "aws_route_table_association" "public_rta" {
  count          = length(var.public_subnet_cidrs)
  subnet_id      = aws_subnet.public_subnet[count.index].id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table" "private_rt" {
  count  = length(var.private_subnet_cidrs)
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = element(aws_nat_gateway.my_natgw.*.id, count.index % length(aws_nat_gateway.my_natgw))
  }

  tags = {
    Name = "private-rt-${count.index + 1}"
  }
}

resource "aws_route_table_association" "private_rta" {
  count          = length(var.private_subnet_cidrs)
  subnet_id      = aws_subnet.private_subnet[count.index].id
  route_table_id = aws_route_table.private_rt[count.index].id
}
```

### Explanation
**resource "aws_route_table" "public_rt"**: Creates a route table for the public subnets.

**vpc_id**: Associates the route table with the VPC.

**route**: Adds a route to the route table that directs all outbound traffic (0.0.0.0/0) to the Internet Gateway.

**tags**: Adds a tag to the route table with the name "public-rt".

**resource "aws_route_table_association" "public_rta"**: Associates the public subnets with the public route table.

**count**: Creates associations based on the number of public subnets.

**subnet_id**: Associates each public subnet with the route table.

**route_table_id**: Specifies the ID of the public route table.

**resource "aws_route_table" "private_rt"**: Creates route tables for the private subnets.

**count**: Creates multiple route tables based on the number of private subnets.

**vpc_id**: Associates each route table with the VPC.

**route**: Adds a route to each route table that directs all outbound traffic to the NAT Gateway.

**tags**: Adds a tag to each route table with a name that includes the index.

**resource "aws_route_table_association" "private_rta"**: Associates the private subnets with the private route tables.

**count**: Creates associations based on the number of private subnets.

**subnet_id**: Associates each private subnet with its respective route table.

**route_table_id**: Specifies the ID of the private route table.

# security_groups.tf

**Bastion-host**: As private servers don't have public Ips. so, we can't login to it directly. here bastion-host will help us. first we will ssh to bastion & from there, we can ssh to private server using its private Ip address. As all these servers are in same VPC so they can connect to each-other using private IP

**Here, Bastion-host allow ssh from anywhere & it can anywhere over internet**.

**servers in private subnet will only allow http request from ALB, ssh from bastion-host and it will go over internet via Nat GW**

**ALB allows clients over internet using http protocol**

```hcl
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
```
### Explanation

## SG for Bastion-host

**resource "aws_security_group" "bastion_sg"**: Creates a security group for the bastion host.

**vpc_id:** Associates the security group with the VPC.

**ingress:** Defines inbound rules for the security group.

**from_port:** Specifies the starting port.

**to_port:** Specifies the ending port.

**protocol:** Specifies the protocol (TCP).

**cidr_blocks:** Specifies the source IP ranges (allowing access from anywhere).

**egress:** Defines outbound rules for the security group.

**from_port:** Specifies the starting port (0).

**to_port:** Specifies the ending port (0).

**protocol:** Specifies the protocol (all protocols).

**cidr_blocks:** Specifies the destination IP ranges (allowing access to anywhere).

**tags:** Adds a tag to the security group with the name "bastion-sg".

## SG for servers in Private Subnet

**resource "aws_security_group" "web_sg":** Creates a security group for the web servers.
**vpc_id:** Associates the security group with the VPC.
**ingress:** Defines inbound rules for the security group.
**from_port:** Specifies the starting port (80 for HTTP, 22 for SSH).
**to_port:** Specifies the ending port (80 for HTTP, 22 for SSH).
**protocol:** Specifies the protocol (TCP)
**security_groups:**: Allows http request from ALB & SSH from Bastion-host
