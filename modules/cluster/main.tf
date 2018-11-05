data "aws_availability_zones" "current" {}

resource "aws_vpc" "main" {
  cidr_block           = "${var.vpc_cidr_block}"
  enable_dns_hostnames = true
}

resource "aws_subnet" "main" {
  vpc_id            = "${aws_vpc.main.id}"
  cidr_block        = "${var.subnet_cidr_block}"
  availability_zone = "${data.aws_availability_zones.current.names[0]}"
}

resource "aws_internet_gateway" "main" {
  vpc_id = "${aws_vpc.main.id}"
}

resource "aws_route_table" "main" {
  vpc_id = "${aws_vpc.main.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.main.id}"
  }
}

resource "aws_route_table_association" "main" {
  subnet_id      = "${aws_subnet.main.id}"
  route_table_id = "${aws_route_table.main.id}"
}

resource "aws_ecs_cluster" "main" {
  name = "${var.name}"
}
