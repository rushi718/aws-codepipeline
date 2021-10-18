output "instance_id" {
  value = aws_instance.webserver1.id
}

output "public_ip" {
  value = aws_instance.webserver1.public_ip
}

output "instance_url" {
  value = "http://${aws_instance.webserver1.public_ip}:${var.instance_port}"
}

output "subnet_id" {

  value=aws_subnet.web-subnet-1.id

}
output "instance_key" {
value = aws_instance.webserver1.key_name
description = "The domain name of load balancer"
}

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}
output "vpc_id" {

  value=data.aws_vpc.pune-training-vpc.id

}
 output "cidr_block"{

   value=data.aws_vpc.pune-training-vpc.cidr_block
 }
output "region" {
  value=data.aws_region.current.id

}