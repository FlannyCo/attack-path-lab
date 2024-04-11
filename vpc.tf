resource "aws_vpc" "ebilling-vpc" {
  cidr_block           = "10.10.0.0/16"
  enable_dns_hostnames = true
  tags = {
    Name      = "ebilling ${random_string.bucket_suffix.result} VPC"
    Stack     = "${var.stack-name}"
    Scenario  = "${var.scenario-name}"
    yor_name  = "ebilling-vpc"
    yor_trace = "75c11fd2-cdf3-42ac-a385-5aea38796b70"
  }
}
#Internet Gateway
resource "aws_internet_gateway" "ebilling-internet-gateway" {
  vpc_id = "${aws_vpc.ebilling-vpc.id}"
  tags = {
    Name      = "ebilling ${random_string.bucket_suffix.result} Internet Gateway"
    Stack     = "${var.stack-name}"
    Scenario  = "${var.scenario-name}"
    yor_name  = "ebilling-internet-gateway"
    yor_trace = "599a96a6-86c6-4ab8-8a71-5274605a0e76"
  }
}
#Public Subnets
resource "aws_subnet" "ebilling-public-subnet-1" {
  availability_zone = "${var.region}a"
  cidr_block        = "10.10.10.0/24"
  vpc_id            = "${aws_vpc.ebilling-vpc.id}"
  tags = {
    Name      = "ebilling ${random_string.bucket_suffix.result} Public Subnet #1"
    Stack     = "${var.stack-name}"
    Scenario  = "${var.scenario-name}"
    yor_name  = "ebilling-public-subnet-1"
    yor_trace = "599b02e3-7069-4ec3-ae1a-bf240ad409d0"
  }
}
resource "aws_subnet" "ebilling-public-subnet-2" {
  availability_zone = "${var.region}b"
  cidr_block        = "10.10.20.0/24"
  vpc_id            = "${aws_vpc.ebilling-vpc.id}"
  tags = {
    Name      = "ebilling ${random_string.bucket_suffix.result} Public Subnet #2"
    Stack     = "${var.stack-name}"
    Scenario  = "${var.scenario-name}"
    yor_name  = "ebilling-public-subnet-2"
    yor_trace = "8ac082be-4e07-4855-90d1-e1e038ff7b53"
  }
}
#Public Subnet Routing Table
resource "aws_route_table" "ebilling-public-subnet-route-table" {
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.ebilling-internet-gateway.id}"
  }
  vpc_id = "${aws_vpc.ebilling-vpc.id}"
  tags = {
    Name      = "ebilling ${random_string.bucket_suffix.result} Route Table for Public Subnet"
    Stack     = "${var.stack-name}"
    Scenario  = "${var.scenario-name}"
    yor_name  = "ebilling-public-subnet-route-table"
    yor_trace = "606ae2a0-4e01-4258-8f46-a1aff5f572ee"
  }
}
#Public Subnets Routing Associations
resource "aws_route_table_association" "ebilling-public-subnet-1-route-association" {
  subnet_id      = "${aws_subnet.ebilling-public-subnet-1.id}"
  route_table_id = "${aws_route_table.ebilling-public-subnet-route-table.id}"
}
resource "aws_route_table_association" "ebilling-public-subnet-2-route-association" {
  subnet_id      = "${aws_subnet.ebilling-public-subnet-2.id}"
  route_table_id = "${aws_route_table.ebilling-public-subnet-route-table.id}"
}