resource "aws_instance" "ec2vm" {
  ami = "ami-066784287e358dad1"
  instance_type = "t2.micro"
  tags = {
    Name = var.vmtag
  }
}