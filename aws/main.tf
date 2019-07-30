variable "profile" {}
variable "region" {
  default = "ap-southeast-2"
}

provider "aws" {
  profile    = var.profile
  region     = var.region
}

resource "aws_instance" "example" {
  ami           = "ami-0dc96254d5535925f"
  instance_type = "t2.micro"

  provisioner "local-exec" {
    command = "echo ${aws_instance.example.public_ip}"
  }
}

resource "aws_eip" "ip" {
  instance = aws_instance.example.id
}

output "ip" {
  value = aws_eip.ip.public_ip
}
