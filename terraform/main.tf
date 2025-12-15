provider "aws" {
  region  = var.region
}

terraform {
  backend "s3" {
    bucket   = "terraform-musta"
    key      = "terraform-obs.tfstate"
    region   = "us-east-2"
    
  }
}

output "vm_public_ip" {
  value = aws_instance.aws-web-server.public_ip
}
