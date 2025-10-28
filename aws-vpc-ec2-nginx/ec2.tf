
resource "aws_instance" "nginxserver" {
  ami = "ami-0279a86684f669718"
    instance_type = "t3.micro"
    subnet_id = aws_subnet.tf_public_subnet.id
    vpc_security_group_ids = [aws_security_group.nginx-sg.id]
    associate_public_ip_address = true
    user_data = <<-EOF
                #!/bin/bash
                sudo apt update -y
                sudo apt install nginx -y
                sudo systemctl start nginx
                EOF
 tags = {
    Name = "NginxServer"
  }
}

