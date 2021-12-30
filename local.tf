locals {
  common_tags = {
    Environment = var.environment_tag
  }

  tags = {
    Owner = "user"
    Name  = "web-server-1"
  }
}
