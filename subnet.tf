# subnets
/* public subnet */ resource "aws_subnet" "subnet-1" {
  vpc_id = "${aws_vpc.gce_vpc.id}"
  cidr_block = "${var.subnet1_cidr_block}"
  availability_zone = "eu-west-1a"
  tags {
    Name = "gce-public"
  }
}
resource "aws_subnet" "subnet-2" {
  vpc_id = "${aws_vpc.gce_vpc.id}"
  cidr_block = "${var.subnet2_cidr_block}"
  availability_zone = "eu-west-1b"
  tags {
    Name = "gce-public"
  }
}
/* private subnet for GCE APP */ resource "aws_subnet" "subnet-3" {
  vpc_id = "${aws_vpc.gce_vpc.id}"
  cidr_block = "${var.subnet3_cidr_block}"
  availability_zone = "eu-west-1b"
  tags {
    Name = "gce-app"
  }
}
resource "aws_subnet" "subnet-4" {
  vpc_id = "${aws_vpc.gce_vpc.id}"
  cidr_block = "${var.subnet4_cidr_block}"
  availability_zone = "eu-west-1a"
  tags {
    Name = "gce-app"
  }
}
/* private subnet for GCE Data */ resource "aws_subnet" "subnet-5" {
  vpc_id = "${aws_vpc.gce_vpc.id}"
  cidr_block = "${var.subnet5_cidr_block}"
  availability_zone = "eu-west-1b"
  tags {
    Name = "gce-data"
  }
}
resource "aws_subnet" "subnet-6" {
  vpc_id = "${aws_vpc.gce_vpc.id}"
  cidr_block = "${var.subnet6_cidr_block}"
   availability_zone = "eu-west-1b"
  tags {
    Name = "gce-data"
  }
}
/* private subnet for GCE Managment */ resource "aws_subnet" "subnet-7" {
  vpc_id = "${aws_vpc.gce_vpc.id}"
  cidr_block = "${var.subnet7_cidr_block}"
  availability_zone = "eu-west-1b"
  tags {
    Name = "gce-Managment"
  }
}
resource "aws_subnet" "subnet-8" {
  vpc_id = "${aws_vpc.gce_vpc.id}"
  cidr_block = "${var.subnet8_cidr_block}"
  availability_zone = "eu-west-1c"
  tags {
    Name = "gce-Managment"
  }
}


resource "aws_subnet" "subnet-9" {
  vpc_id = "${aws_vpc.gce_vpc.id}"
   cidr_block = "${var.subnet9_cidr_block}"
  availability_zone = "eu-west-1a"
  tags {
    Name = "gce-Managment"
  }
}

  
  
