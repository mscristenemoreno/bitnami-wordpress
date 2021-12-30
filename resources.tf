# INTERNET GATEWAY #
resource "aws_internet_gateway" "igw" {
  vpc_id = module.vpc.vpc_id

  tags = merge(local.common_tags, { Name = "${var.environment_tag}-igw" })
}

resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow inbound SSH traffic from my IP"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [module.vpc.vpc_cidr_block]
  }

  tags = {
    Name = "allow_ssh"
  }
}

# EC2
resource "aws_instance" "web_server1" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = var.instance_size
  subnet_id              = element(module.vpc.private_subnets, 0)
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]
  key_name               = var.key_name

  tags = merge(local.common_tags, { Name = "${var.environment_tag}-webserver" })
}

# Hosting Webserver and Wordpress
resource "null_resource" "test1" {
  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file(var.private_key)
    host        = aws_instance.web_server1.public_ip
  }
  provisioner "remote-exec" {
    inline = [
      "sudo yum install http -y",
      "sudo yum install php -y",
      "sudo systemctl start httpd",
      "sudo systemctl start php",
      "cd /var/www/html",
      "sudo wget https://wordpress.org/latest.zip",
      "sudo unzip latest.zip"
    ]
  }
}
