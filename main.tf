resource "aws_instance" "ec2vm" {
  ami = "ami-066784287e358dad1"
  instance_type = "t2.micro"
  tags = {
    Name = "tflocalexecvm"
  }
  key_name = "27augkey"
  
  provisioner "file" {
    destination = "/tmp/data.txt"
    source = "./index.html"
  }
  provisioner "remote-exec" {
    inline = [ 
        "sudo yum update -y",
        "sudo yum install nginx -y",
        "sudo systemctl enable nginx",
        "sudo systemctl start nginx",
        "sudo echo 'welcome to webserver 1' >/usr/share/nginx/html/index.html"
     ]
   
  }
  connection {
    user = "ec2-user" #default ami linux username
    private_key = file("./27augkey.pem")
    host = self.public_ip
    type = "ssh"
  }
}
output "public_ip" {
  value = aws_instance.ec2vm.public_ip
}