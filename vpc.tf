#VPC creation
resource "aws_vpc" "gce_vpc" {
  cidr_block = "${var.vpc_cidr_block}"
  instance_tenancy = "default"
  tags {
    Name = "gce_vpc"
  }
}
/* public route table */ resource "aws_internet_gateway" "gce-int-gateway" {
    vpc_id = "${aws_vpc.gce_vpc.id}"
}
resource "aws_route_table" "public-route" {
  vpc_id = "${aws_vpc.gce_vpc.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.gce-int-gateway.id}"
  }
  tags {
    Name = "public-route"
  }
}
resource "aws_route_table_association" "public_route_association1" {
  subnet_id = "${aws_subnet.subnet-1.id}"
  route_table_id = "${aws_route_table.public-route.id}"
}
resource "aws_route_table_association" "public_route_association2" {
  subnet_id = "${aws_subnet.subnet-2.id}"
  route_table_id = "${aws_route_table.public-route.id}"
}
/* private subnet */ resource "aws_eip" "gce-eip" {
}
resource "aws_nat_gateway" "gce-nat" {
  allocation_id = "${aws_eip.gce-eip.id}"
  subnet_id = "${aws_subnet.subnet-1.id}"
  tags {
    Name = "GCE-NAT"
  }
}
resource "aws_route_table" "private-route" {
  vpc_id = "${aws_vpc.gce_vpc.id}"
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = "${aws_nat_gateway.gce-nat.id}"
  }
tags {
    Name = "private-route"
  }
}

/*resource "aws_route" "devops_to_qa" {
    route_table_id = "${aws_route_table.private-route.id}"
    destination_cidr_block = "10.224.113.0/26" // Jenkins's cidr
    vpc_peering_connection_id = "pcx-0784f2429ad79f58e"
}*/

resource "aws_route_table_association" "private_route_association1" {
  subnet_id = "${aws_subnet.subnet-3.id}"
  route_table_id = "${aws_route_table.private-route.id}"
}
resource "aws_route_table_association" "private_route_association2" {
  subnet_id = "${aws_subnet.subnet-4.id}"
  route_table_id = "${aws_route_table.private-route.id}"
}
resource "aws_route_table_association" "private_route_association3" {
  subnet_id = "${aws_subnet.subnet-5.id}"
  route_table_id = "${aws_route_table.private-route.id}"
}
resource "aws_route_table_association" "private_route_association4" {
  subnet_id = "${aws_subnet.subnet-6.id}"
  route_table_id = "${aws_route_table.private-route.id}"
}
resource "aws_route_table_association" "private_route_association5" {
  subnet_id = "${aws_subnet.subnet-7.id}"
  route_table_id = "${aws_route_table.private-route.id}"

}
resource "aws_route_table_association" "private_route_association6" {
  subnet_id = "${aws_subnet.subnet-8.id}"
  route_table_id = "${aws_route_table.private-route.id}"
}
resource "aws_route_table_association" "private_route_association7" {
  subnet_id = "${aws_subnet.subnet-9.id}"
  route_table_id = "${aws_route_table.private-route.id}"
}
//--------------------------------------------------------
