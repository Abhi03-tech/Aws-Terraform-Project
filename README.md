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

Select create user
![2](https://github.com/user-attachments/assets/3e61bab8-b4da-45ac-83e6-e0207ed93bda)

Give a username & click next
![3](https://github.com/user-attachments/assets/7eb5067a-b9f4-4a66-aa8a-4a6add1196bb)

Select permissions
![4](https://github.com/user-attachments/assets/060820fa-d049-46b5-8977-004965ba12b4)

Select AdministratorAccess
![5](https://github.com/user-attachments/assets/b4b21ea0-83d1-4b53-9781-e8df5c791d4a)

Select Create user
![6](https://github.com/user-attachments/assets/7be9bfb2-8848-4a2b-886f-66d5e20c2b1c)

Now, Click on Create access key
![7](https://github.com/user-attachments/assets/6fec1cff-9029-4af7-8c8c-fb268e97cb05)

Select any suitable use-case
![8](https://github.com/user-attachments/assets/bc0faba3-526e-4796-966f-b697b8a502b5)

Select the Checkbox & then next
![9](https://github.com/user-attachments/assets/c54e267a-02bc-40cc-9e83-f3de5ad41378)

Description is optional. Create access key.
![10](https://github.com/user-attachments/assets/9975a714-a935-4bb1-a020-7dbbdd0166a3)

Download the csv file for future references
![11](https://github.com/user-attachments/assets/a4b02935-49ec-4d86-870f-bf27f7fc4148)

As, Aws Cli should be installed on the local system.
Now, open cmd (i am using windows) and run the command "aws configure --profile terraform". this will create a profile locally in .aws directory, that stores the credentials.

just copy the access key & secret access key of iam user & paste. select a desired region & output format.
![12](https://github.com/user-attachments/assets/d3563cff-91c8-42f4-81a3-a0fd2e2c3feb)

Change the directory to .aws & see the available files there.
![13](https://github.com/user-attachments/assets/ae9ae7ba-5f2a-46e5-80c8-aea42f0968ef)

Open the credentials file using notepad or any other terminal. cmd "notepad credentials"
![14](https://github.com/user-attachments/assets/53ba14a9-7ab4-4715-83eb-2b4a12f5cd9d)

Now, create a project directory and open it in VS code.
before jumping into writing the configuration files for our project, complete some prerequisite like let our vs code know where our credentials are saved. so, we don't have to put our credentials in conf. file.

Click on Extensions & install AWS Toolkit. In my case, it's installed.
![15](https://github.com/user-attachments/assets/ca0cceb7-8872-416a-9c07-c665404d7e66)

Click on View & then Open View
![16](https://github.com/user-attachments/assets/0c327dfe-2b90-4a11-a4de-0f0fd4ab7193)

Select the option AWS
![17](https://github.com/user-attachments/assets/d11baeb6-40f0-4ab0-afb2-2d03caf988bb)

Right now vs code is connected with default profile, click on that.
![18](https://github.com/user-attachments/assets/c8e81b2b-a519-49ed-85e9-2d2d5f47f286)

Before terraform profile, there's is X sign means it's not authenticated by VS code till now. Click on that profile.
![19](https://github.com/user-attachments/assets/72f3d316-9395-4ee1-add1-e0801e927129)

Now, profile terraform is connected with Vs code editor & it's in use.
![21](https://github.com/user-attachments/assets/5ad51583-9060-4c3b-802b-a16fb574e22f)
