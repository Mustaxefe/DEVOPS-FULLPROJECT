provider "aws" {
  region  = var.region
}

terraform {
  backend "s3" {
    bucket   = "terraform-musta"
    key      = "terraform-obs.tfstate"
    region   = "sa-east-1"
    
  }
}

output "vm_public_ip" {
  value = aws_instance.aws-web-server.public_ip
}
