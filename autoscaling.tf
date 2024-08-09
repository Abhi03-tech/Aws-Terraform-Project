resource "aws_launch_template" "web_launch_template" {
  name_prefix   = "web-server-"
  image_id      = var.ami
  instance_type = var.instance_type
  key_name      = var.key_name

  network_interfaces {
    associate_public_ip_address = false
    security_groups             = [aws_security_group.web_sg.id]
  }

  user_data = base64encode(<<EOF
#!/bin/bash
yum update -y
yum install -y httpd
echo 'Hello World from Terraform!' > /var/www/html/index.html
systemctl start httpd
systemctl enable httpd
EOF
  )
}

resource "aws_autoscaling_group" "web_asg" {
  vpc_zone_identifier = aws_subnet.private_subnet.*.id
  launch_template {
    id      = aws_launch_template.web_launch_template.id
    version = "$Latest"
  }

  min_size = 1
  max_size = 3
  desired_capacity = 2

  tag {
      key                 = "Name"
      value               = "web-server"
      propagate_at_launch = true
    }
}