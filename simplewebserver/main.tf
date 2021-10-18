provider "aws" {
  region  = "${var.region}"
}

# Accessing the pune-training-vpc

data "aws_vpc"  "pune-training-vpc" {
   id = "vpc-05eafc50779d7ccdd"
} 

#Iam account details
data "aws_caller_identity" "current" {}

#Current region
data "aws_region" "current" {}



# Public Subnet for webserver 1

resource "aws_subnet" "web-subnet-1" {
  vpc_id            = data.aws_vpc.pune-training-vpc.id
  availability_zone = "ap-south-1a"
  cidr_block        = "10.0.0.144/28"
  map_public_ip_on_launch = true
  tags = {
    Name: 	"terratest_web-subnet-1"		
     Owner: "732876433851"	
     Purpose: "task_for_3-tier_architecture"
     Creation_date: "1/10/2021"
     Expiration_date: "1/10/2021"
  }

}

# Create an internet gateway to give our subnet access to the outside world
data "aws_internet_gateway" "my-internet-gateway-1" {
  filter {
    name   = "attachment.vpc-id"
    values = [data.aws_vpc.pune-training-vpc.id]
  }
}


# Create Route tables for web layer
resource "aws_route_table" "web1-layer-route-table" {
  vpc_id = data.aws_vpc.pune-training-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${data.aws_internet_gateway.my-internet-gateway-1.id}"
  }

  tags ={
    Name: 	"web1-layer-route-table"		
    Owner: "732876433851"	
    Purpose: "task_for_3-tier_architecture"
    Creation_date: "1/10/2021"
    Expiration_date: "1/10/2021"
  }
}

resource "aws_route_table_association" "web1-route-table-association" {

  subnet_id      = "${aws_subnet.web-subnet-1.id}"
  route_table_id = "${aws_route_table.web1-layer-route-table.id}"
}

#security group for webservers

resource "aws_security_group" "webserver_sg" {
  name        = "allow_http"
  description = "Allow http inbound traffic"
  vpc_id      = data.aws_vpc.pune-training-vpc.id

  ingress {
    description = "HTTP from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

   ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

   ingress {
    description     = "Allow traffic from application layer"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags =  {
    Name: 	"terratest_webserver_sg"		
    Owner: "732876433851"	
    Purpose: "task_for_3-tier_architecture"
    Creation_date: "1/10/2021"
    Expiration_date: "1/10/2021"
  }
}

# Create EC2 instances for webserver1

resource "aws_instance" "webserver1" {
  ami             = "${var.web_ami}"
  instance_type   = "${var.web_instance}"
  security_groups = ["${aws_security_group.webserver_sg.id}"]
  subnet_id       = "${aws_subnet.web-subnet-1.id}"
  key_name        = "fizzb"
  user_data=<<-EOF
	#!/bin/bash
  
	sudo yum update -y 
  sudo yum install -y httpd httpd-tools mod_ssl
  sudo systemctl enable httpd 
  sudo systemctl start httpd  
	#sudo bash -c 'echo i am a webserver1 $(hostname -f)> /var/www/html/index.html'
  sudo bash -c 'echo Hello World!> /var/www/html/index.html'

	EOF
  tags ={
    Name: 	"terratest_webservers1"		
    Owner: "732876433851"	
    Purpose: "task_for_3-tier_architecture"
    Creation_date: "1/10/2021"
    Expiration_date: "1/10/2021"
  }
}




# Public Subnet for webserver 2

resource "aws_subnet" "web-subnet-2" {
  
  vpc_id            = data.aws_vpc.pune-training-vpc.id
  availability_zone = "ap-south-1b"
  cidr_block        = "10.0.0.176/28"
   map_public_ip_on_launch = true
  tags = {
    Name: 	"web-subnet-2"		
    Owner: "732876433851"	
    Purpose: "task_for_3-tier_architecture"
    Creation_date: "1/10/2021"
    Expiration_date: "1/10/2021"
  }

}

# Create Route tables for web2 layer
resource "aws_route_table" "web2-layer-route-table" {
  vpc_id = data.aws_vpc.pune-training-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${data.aws_internet_gateway.my-internet-gateway-1.id}"
  }

  tags ={
    Name: 	"web2-layer-route-table"		
    Owner: "732876433851"	
    Purpose: "task_for_3-tier_architecture"
    Creation_date: "1/10/2021"
    Expiration_date: "1/10/2021"
  }
}



resource "aws_route_table_association" "web2-route-table-association" {

  subnet_id      = "${aws_subnet.web-subnet-2.id}"
  route_table_id = "${aws_route_table.web2-layer-route-table.id}"
}

# Create EC2 instances for webserver2

resource "aws_instance" "webserver2" {
  ami             = "${var.web_ami}"
  instance_type   = "${var.web_instance}"
  security_groups = ["${aws_security_group.webserver_sg.id}"]
  subnet_id       = "${aws_subnet.web-subnet-2.id}"
  key_name        = "fizzb"
  user_data=<<-EOF
	#!/bin/bash
	sudo yum update -y 
  sudo yum install -y httpd httpd-tools mod_ssl
  sudo systemctl enable httpd 
  sudo systemctl start httpd  
	sudo bash -c 'echo i am a webserver2 $(hostname -f)> /var/www/html/index.html'
	EOF
  tags ={
    Name: 	"webservers2"		
    Owner: "732876433851"	
    Purpose: "task_for_3-tier_architecture"
    Creation_date: "1/10/2021"
    Expiration_date: "1/10/2021"
  }
}