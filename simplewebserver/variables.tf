variable "region" {
  description = "AWS region to create VPC"
  default     = "ap-south-1"
}


variable "websg_name" {
  description = "Name of security group for webservers"
  default     = "webserver_sg"
}

variable "web_ami" {
  description = "AMI of webservers"
  default     = "ami-0a23ccb2cdd9286bb"
}

variable "web_instance" {
  description = "Instance type of webservers"
  default     = "t2.micro"
}

variable "lb_name" {
  description = "Name of the application load balancer"
  default     = "applb"
}

variable "tg_name" {
  description = "Name of the application load balancer target group"
  default     = "applb-tg"
}

variable "tg_port" {
  description = "Enter the port for the application load balancer target group"
  default     = "80"
}

variable "tg_protocol" {
  description = "Enter the protocol for the application load balancer target group"
  default     = "HTTP"
}

variable "listener_port" {
  description = "Enter the port for the application load balancer target group"
  default     = "80"
}

variable "listener_protocol" {
  description = "Enter the protocol for the application load balancer target group"
  default     = "HTTP"
}
variable "instance_port" {
  description = "The port the EC2 Instance should listen on for HTTP requests."
  type        = number
  default     = 80
}

variable "webserver1_name" {
  description = "The Name tag to set for the EC2 Instance."
  type        = string
  default     = "webserver1"
}
variable "webserver2_name" {
  description = "The Name tag to set for the EC2 Instance."
  type        = string
  default     = "webserver2"
}
variable "database_name" {
  description = "The Name tag to set for the EC2 Instance."
  type        = string
  default     = "database"
}
variable "instance_text" {
  description = "The text the EC2 Instance should return when it gets an HTTP request."
  type        = string
  default     = "Hello World!"
}