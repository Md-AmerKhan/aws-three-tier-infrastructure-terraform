
resource "aws_instance" "web" {
  count = 2

  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.private_subnet_ids[count.index]
  vpc_security_group_ids      = [var.web_sg_id]
  key_name                    = var.ssh_key_name
  associate_public_ip_address = false

  user_data_replace_on_change = true

  user_data = <<-EOF
    #!/bin/bash
    amazon-linux-extras install nginx1 -y
    systemctl enable nginx
    systemctl start nginx
    echo "<h1>Web Server ${count.index + 1}</h1>" > /usr/share/nginx/html/index.html
  EOF

  tags = {
    Name = "terraform-3tier-web-${count.index + 1}"
    Tier = "Web"
  }
}

resource "aws_instance" "app" {
  count = 2

  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.private_subnet_ids[count.index + 2]
  vpc_security_group_ids      = [var.app_sg_id]
  key_name                    = var.ssh_key_name
  associate_public_ip_address = false

  user_data_replace_on_change = true

  user_data = <<-EOF
    #!/bin/bash
    amazon-linux-extras install nginx1 -y
    systemctl enable nginx
    systemctl start nginx
    echo "<h1>Application Server ${count.index + 1}</h1>" > /usr/share/nginx/html/index.html
  EOF

  tags = {
    Name = "terraform-3tier-app-${count.index + 1}"
    Tier = "Application"
  }
}

resource "aws_instance" "database" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.private_subnet_ids[4]
  vpc_security_group_ids      = [var.database_sg_id]
  key_name                    = var.ssh_key_name
  associate_public_ip_address = false

  user_data_replace_on_change = true

  user_data = <<-EOF
    #!/bin/bash
    yum install -y mariadb-server
    systemctl enable mariadb
    systemctl start mariadb
  EOF

  tags = {
    Name = "terraform-3tier-database"
    Tier = "Database"
  }
}

resource "aws_lb_target_group_attachment" "web" {
  count = 2

  target_group_arn = var.web_target_group_arn
  target_id        = aws_instance.web[count.index].id
  port             = 80
}

resource "aws_lb_target_group_attachment" "app" {
  count = 2

  target_group_arn = var.app_target_group_arn
  target_id        = aws_instance.app[count.index].id
  port             = 80
}
