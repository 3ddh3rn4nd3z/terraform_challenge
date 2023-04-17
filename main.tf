provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "example" {
  ami           = "ami-0721c9af7b9b75114"
  instance_type = "t2.micro"
}