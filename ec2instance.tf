resource "aws_instance" "instance1" {
  ami = "${var.ec2_instance_ami}"

   disable_api_termination = "true"

instance_type = "m4.4xlarge"
#  availability_zone = "eu-west-1b"
  key_name = "${var.aws_key_name}"
  associate_public_ip_address = false
  subnet_id = "${aws_subnet.subnet-4.id}"
  vpc_security_group_ids = ["${aws_security_group.security_group_1.id}"]
  root_block_device {
    volume_type = "gp2"
    volume_size = "1000"
    delete_on_termination = "true"
  }
  tags {
    Name = "CLOUDERA_MGR"
  }
  lifecycle {
      create_before_destroy = true
    }
}

resource "aws_instance" "instance3" {
  ami = "${var.ec2_instance_ami}"

   disable_api_termination = "true"

instance_type = "m4.4xlarge"
#  availability_zone = "eu-west-1b"
  key_name = "${var.aws_key_name}"
  associate_public_ip_address = false
  subnet_id = "${aws_subnet.subnet-4.id}"
  vpc_security_group_ids = ["${aws_security_group.security_group_1.id}"]
  root_block_device {
    volume_type = "gp2"
    volume_size = "500"
    delete_on_termination = "true"
  }
  tags {
    Name = "MASTER-02"
  }
  lifecycle {
      create_before_destroy = false
    }
}

resource "aws_instance" "instance4" {
  ami = "${var.ec2_instance_ami}"

   disable_api_termination = "true"

instance_type = "m4.4xlarge"
#  availability_zone = "eu-west-1b"
  key_name = "${var.aws_key_name}"
  associate_public_ip_address = false
  subnet_id = "${aws_subnet.subnet-4.id}"
  vpc_security_group_ids = ["${aws_security_group.security_group_1.id}"]
  root_block_device {
    volume_type = "gp2"
    volume_size = "500"
    delete_on_termination = "true"
  }
  tags {
    Name = "MASTER-03"
  }
  lifecycle {
      create_before_destroy = false
    }
}

resource "aws_instance" "instance5" {
  ami = "${var.ec2_instance_ami}"

   disable_api_termination = "true"

instance_type = "m4.4xlarge"
#  availability_zone = "eu-west-1b"
  key_name = "${var.aws_key_name}"
  associate_public_ip_address = false
  subnet_id = "${aws_subnet.subnet-4.id}"
  vpc_security_group_ids = ["${aws_security_group.security_group_1.id}"]
  root_block_device {
    volume_type = "gp2"
    volume_size = "100"
    delete_on_termination = "true"
  }
  tags {
    Name = "MASTER-04"
  }
  lifecycle {
      create_before_destroy = false
    }
}


resource "aws_instance" "instance6" {
  ami = "${var.ec2_instance_ami}"

   disable_api_termination = "true"

instance_type = "m4.4xlarge"
#  availability_zone = "eu-west-1b"
  key_name = "${var.aws_key_name}"
  associate_public_ip_address = false
  subnet_id = "${aws_subnet.subnet-4.id}"
  vpc_security_group_ids = ["${aws_security_group.security_group_1.id}"]
  root_block_device {
    volume_type = "gp2"
    volume_size = "1000"
    delete_on_termination = "true"
  }
  tags {
    Name = "WORKER-01"
  }
  lifecycle {
      create_before_destroy = false
    }
}

resource "aws_instance" "instance7" {
  ami = "${var.ec2_instance_ami}"

   disable_api_termination = "true"

instance_type = "m4.4xlarge"
#  availability_zone = "eu-west-1b"
  key_name = "${var.aws_key_name}"
  associate_public_ip_address = false
  subnet_id = "${aws_subnet.subnet-4.id}"
  vpc_security_group_ids = ["${aws_security_group.security_group_1.id}"]
  root_block_device {
    volume_type = "gp2"
    volume_size = "1000"
    delete_on_termination = "true"
  }
  tags {
    Name = "WORKER-02"
  }
  lifecycle {
      create_before_destroy = false
    }
}

resource "aws_instance" "instance8" {
  ami = "${var.ec2_instance_ami}"

   disable_api_termination = "true"

instance_type = "m4.4xlarge"
#  availability_zone = "eu-west-1b"
  key_name = "${var.aws_key_name}"
  associate_public_ip_address = false
  subnet_id = "${aws_subnet.subnet-4.id}"
  vpc_security_group_ids = ["${aws_security_group.security_group_1.id}"]
  root_block_device {
    volume_type = "gp2"
    volume_size = "1000"
    delete_on_termination = "true"
  }
  tags {
    Name = "WORKER-03"
  }
  lifecycle {
      create_before_destroy = false
    }
}



resource "aws_instance" "instance9" {
  ami = "${var.ec2_instance_ami}"

   disable_api_termination = "true"

instance_type = "m4.xlarge"
#  availability_zone = "eu-west-1b"
  key_name = "${var.aws_key_name}"
  associate_public_ip_address = false
  subnet_id = "${aws_subnet.subnet-4.id}"
  vpc_security_group_ids = ["${aws_security_group.security_group_1.id}"]
  root_block_device {
    volume_type = "gp2"
    volume_size = "500"
    delete_on_termination = "true"
  }
  tags {
    Name = "KAFKA-01"
  }
  lifecycle {
      create_before_destroy = false
    }
}



resource "aws_instance" "instance10" {
  ami = "${var.ec2_instance_ami}"

   disable_api_termination = "true"

instance_type = "m4.xlarge"
#  availability_zone = "eu-west-1b"
  key_name = "${var.aws_key_name}"
  associate_public_ip_address = false
  subnet_id = "${aws_subnet.subnet-4.id}"
  vpc_security_group_ids = ["${aws_security_group.security_group_1.id}"]
  root_block_device {
    volume_type = "gp2"
    volume_size = "500"
    delete_on_termination = "true"
  }
  tags {
    Name = "KAFKA-02"
  }
  lifecycle {
      create_before_destroy = false
    }
}



resource "aws_instance" "instance11" {
  ami = "${var.ec2_instance_ami}"

   disable_api_termination = "true"

instance_type = "m4.xlarge"
#  availability_zone = "eu-west-1b"
  key_name = "${var.aws_key_name}"
  associate_public_ip_address = false
  subnet_id = "${aws_subnet.subnet-4.id}"
  vpc_security_group_ids = ["${aws_security_group.security_group_1.id}"]
  root_block_device {
    volume_type = "gp2"
    volume_size = "500"
    delete_on_termination = "true"
  }
  tags {
    Name = "KAFKA-03"
  }
  lifecycle {
      create_before_destroy = false
    }
}

resource "aws_instance" "instance12" {
  ami = "${var.ec2_instance_ami}"

   disable_api_termination = "true"

instance_type = "m4.xlarge"
#  availability_zone = "eu-west-1b"
  key_name = "${var.aws_key_name}"
  associate_public_ip_address = false
  subnet_id = "${aws_subnet.subnet-4.id}"
  vpc_security_group_ids = ["${aws_security_group.security_group_1.id}"]
  root_block_device {
    volume_type = "gp2"
    volume_size = "500"
    delete_on_termination = "true"
  }
  tags {
    Name = "KUDU-01"
  }
  lifecycle {
      create_before_destroy = false
    }
}


resource "aws_instance" "instance13" {
  ami = "${var.ec2_instance_ami}"

   disable_api_termination = "true"

instance_type = "m4.xlarge"
#  availability_zone = "eu-west-1b"
  key_name = "${var.aws_key_name}"
  associate_public_ip_address = false
  subnet_id = "${aws_subnet.subnet-4.id}"
  vpc_security_group_ids = ["${aws_security_group.security_group_1.id}"]
  root_block_device {
    volume_type = "gp2"
    volume_size = "500"
    delete_on_termination = "true"
  }
  tags {
    Name = "KUDU-02"
  }
  lifecycle {
      create_before_destroy = false
    }
}


resource "aws_instance" "instance14" {
  ami = "${var.ec2_instance_ami}"

   disable_api_termination = "true"

instance_type = "m4.xlarge"
#  availability_zone = "eu-west-1b"
  key_name = "${var.aws_key_name}"
  associate_public_ip_address = false
  subnet_id = "${aws_subnet.subnet-4.id}"
  vpc_security_group_ids = ["${aws_security_group.security_group_1.id}"]
  root_block_device {
    volume_type = "gp2"
    volume_size = "500"
    delete_on_termination = "true"
  }
  tags {
    Name = "KUDU-03"
  }
  lifecycle {
      create_before_destroy = false
    }
}

resource "aws_instance" "instance15" {
  ami = "${var.ec2_instance_ami}"

   disable_api_termination = "true"

instance_type = "m4.xlarge"
#  availability_zone = "eu-west-1b"
  key_name = "${var.aws_key_name}"
  associate_public_ip_address = false
  subnet_id = "${aws_subnet.subnet-4.id}"
  vpc_security_group_ids = ["${aws_security_group.security_group_1.id}"]
  root_block_device {
    volume_type = "gp2"
    volume_size = "500"
    delete_on_termination = "true"
  }
  tags {
    Name = "KUDU-04"
  }
  lifecycle {
      create_before_destroy = false
    }
}
resource "aws_instance" "instance16" {
  ami = "${var.ec2_instance_ami}"

   disable_api_termination = "true"

instance_type = "m4.xlarge"
#  availability_zone = "eu-west-1b"
  key_name = "${var.aws_key_name}"
  associate_public_ip_address = false
  subnet_id = "${aws_subnet.subnet-4.id}"
  vpc_security_group_ids = ["${aws_security_group.security_group_1.id}"]
  root_block_device {
    volume_type = "gp2"
    volume_size = "500"
    delete_on_termination = "true"
  }
  tags {
    Name = "KUDU-05"
  }
  lifecycle {
      create_before_destroy = false
    }
}

resource "aws_instance" "instance17" {
  ami = "${var.ec2_instance_ami}"

   disable_api_termination = "true"

instance_type = "m4.xlarge"
#  availability_zone = "eu-west-1b"
  key_name = "${var.aws_key_name}"
  associate_public_ip_address = false
  subnet_id = "${aws_subnet.subnet-4.id}"
  vpc_security_group_ids = ["${aws_security_group.security_group_1.id}"]
  root_block_device {
    volume_type = "gp2"
    volume_size = "100"
    delete_on_termination = "true"
  }
  tags {
    Name = "LDAP-01"
  }
  lifecycle {
      create_before_destroy = false
    }
}

resource "aws_instance" "instance18" {
  ami = "${var.ec2_instance_ami}"

   disable_api_termination = "true"

instance_type = "t2.medium"
#  availability_zone = "eu-west-1b"
  key_name = "gce-app-qa"
  associate_public_ip_address = false
  subnet_id = "${aws_subnet.subnet-4.id}"
  vpc_security_group_ids = ["${aws_security_group.security_group_2.id}"]
  root_block_device {
    volume_type = "gp2"
    volume_size = "50"
    delete_on_termination = "true"
  }
  tags {
    Name = "Kong"
  }
  lifecycle {
      create_before_destroy = false
    }
}
resource "aws_instance" "instance19" {
  ami = "${var.ec2_instance_ami}"

   disable_api_termination = "false"

instance_type = "t2.medium"
#  availability_zone = "eu-west-1b"
  key_name = "gce-app-qa"
  associate_public_ip_address = false
  subnet_id = "${aws_subnet.subnet-4.id}"
  vpc_security_group_ids = ["${aws_security_group.security_group_2.id}"]
  root_block_device {
    volume_type = "gp2"
    volume_size = "50"
    delete_on_termination = "true"
  }
  tags {
    Name = "Rule-engine"
  }
  lifecycle {
      create_before_destroy = false
    }
}
resource "aws_instance" "instance20" {
  ami = "ami-0d380635689e04da7"

   disable_api_termination = "false"

instance_type = "t2.medium"
#  availability_zone = "eu-west-1b"
  key_name = "gce-app-qa"
  associate_public_ip_address = false
  subnet_id = "${aws_subnet.subnet-4.id}"
  vpc_security_group_ids = ["${aws_security_group.security_group_2.id}"]
  root_block_device {
    volume_type = "gp2"
    volume_size = "50"
    delete_on_termination = "true"
  }
  tags {
    Name = "Kong-2"
  }
  lifecycle {
      create_before_destroy = false
    }
}

resource "aws_instance" "instance22" {
  ami = "${var.ec2_instance_ami}"

   disable_api_termination = "true"

instance_type = "t2.medium"
#  availability_zone = "eu-west-1b"
  key_name = "${var.aws_key_name}"
  associate_public_ip_address = false
  subnet_id = "${aws_subnet.subnet-4.id}"
  vpc_security_group_ids = ["${aws_security_group.security_group_1.id}"]
  root_block_device {
    volume_type = "gp2"
    volume_size = "50"
    delete_on_termination = "true"
  }
  tags {
    Name = "redis-test"
  }
  lifecycle {
      create_before_destroy = false
    }
}


resource "aws_instance" "instance23" {
  ami = "${var.ec2_instance_ami}"

   disable_api_termination = "true"

instance_type = "t2.medium"
#  availability_zone = "eu-west-1b"
  key_name = "${var.aws_key_name}"
  associate_public_ip_address = false
  subnet_id = "${aws_subnet.subnet-4.id}"
  vpc_security_group_ids = ["${aws_security_group.security_group_1.id}"]
  root_block_device {
    volume_type = "gp2"
    volume_size = "50"
    delete_on_termination = "true"
  }
  tags {
    Name = "keycloak"
  }
  lifecycle {
      create_before_destroy = false
    }
}

resource "aws_instance" "cyber" {
  ami = "ami-0d3bb859f5f3610a4"
iam_instance_profile = "ec2-cloudwatchlogs_profile"

   disable_api_termination = "true"

instance_type = "m4.2xlarge"
  availability_zone = "eu-west-1b"
  key_name = "${var.aws_key_name}"
  associate_public_ip_address = false
  subnet_id = "subnet-063fe82100eda4f14"
  vpc_security_group_ids = ["sg-042c7b4ae6f582371"]
  root_block_device {
    volume_type = "gp2"
    volume_size = "500"
    delete_on_termination = "true"
}
  tags {
    Name = "cyber"
  }
  lifecycle {
      create_before_destroy = false
    }
}

resource "aws_instance" "instance24" {
  ami = "${var.ec2_instance_ami}"

   disable_api_termination = "true"

instance_type = "c4.4xlarge"
#  availability_zone = "eu-west-1b"
  key_name = "${var.aws_key_name}"
  associate_public_ip_address = false
  subnet_id = "${aws_subnet.subnet-4.id}"
  vpc_security_group_ids = ["${aws_security_group.security_group_1.id}"]
  root_block_device {
    volume_type = "gp2"
    volume_size = "10"
    delete_on_termination = "true"
  }
  tags {
    Name = "presto-coordinator"
  }
  lifecycle {
      create_before_destroy = false
    }
}
resource "aws_instance" "instance25" {
  ami = "${var.ec2_instance_ami}"

   disable_api_termination = "true"

instance_type = "c4.4xlarge"
#  availability_zone = "eu-west-1b"
  key_name = "${var.aws_key_name}"
  associate_public_ip_address = false
  subnet_id = "${aws_subnet.subnet-4.id}"
  vpc_security_group_ids = ["${aws_security_group.security_group_1.id}"]
  root_block_device {
    volume_type = "gp2"
    volume_size = "10"
    delete_on_termination = "true"
  }
  tags {
    Name = "presto-worker-1"
  }
  lifecycle {
      create_before_destroy = false
    }
}
resource "aws_instance" "instance26" {
  ami = "${var.ec2_instance_ami}"

   disable_api_termination = "true"

instance_type = "c4.4xlarge"
#  availability_zone = "eu-west-1b"
  key_name = "${var.aws_key_name}"
  associate_public_ip_address = false
  subnet_id = "${aws_subnet.subnet-4.id}"
  vpc_security_group_ids = ["${aws_security_group.security_group_1.id}"]
  root_block_device {
    volume_type = "gp2"
    volume_size = "10"
    delete_on_termination = "true"
  }
  tags {
    Name = "presto-worker-2"
  }
  lifecycle {
      create_before_destroy = false
    }
}





resource "aws_instance" "Com-Hem-3-1-qa" {
  ami = "ami-0ff662a8c231c194c"

   disable_api_termination = "true"

instance_type = "t2.micro"
  availability_zone = "eu-west-1b"
  key_name = "${var.aws_key_name}"
  associate_public_ip_address = false
  subnet_id = "${aws_subnet.subnet-5.id}"
  vpc_security_group_ids = ["${aws_security_group.security_group_1.id}"]
  root_block_device {
    volume_type = "gp2"
    volume_size = "10"
    delete_on_termination = "true"
  }
  tags {
    Name = "Com-Hem-3.1-qa"
  }
  lifecycle {
      create_before_destroy = false
    }
}




resource "aws_instance" "Allianz-qa" {
  ami = "ami-0ff662a8c231c194c"

  # disable_api_termination = "false"

instance_type = "t2.medium"
  availability_zone = "eu-west-1b"
  key_name = "${var.aws_key_name}"
  associate_public_ip_address = false
  subnet_id = "${aws_subnet.subnet-5.id}"
  vpc_security_group_ids = ["${aws_security_group.security_group_1.id}"]
  root_block_device {
    volume_type = "gp2"
    volume_size = "10"
    delete_on_termination = "true"
  }
  tags {
    Name = "Allianz-qa"
  }
  lifecycle {
      create_before_destroy = false
    }
}





resource "aws_instance" "Baywalk-qa" {
  ami = "ami-0ff662a8c231c194c"

   disable_api_termination = "true"

instance_type = "t2.medium"
  availability_zone = "eu-west-1b"
  key_name = "${var.aws_key_name}"
  associate_public_ip_address = false
  subnet_id = "${aws_subnet.subnet-5.id}"
  vpc_security_group_ids = ["${aws_security_group.security_group_1.id}"]
  root_block_device {
    volume_type = "gp2"
    volume_size = "10"
    delete_on_termination = "true"
  }
  tags {
    Name = "Baywalk-qa"
  }
  lifecycle {
      create_before_destroy = false
    }
}




resource "aws_instance" "Cyber-demo-qa" {
  ami = "ami-0ff662a8c231c194c"

   disable_api_termination = "true"

instance_type = "t2.medium"
  availability_zone = "eu-west-1b"
  key_name = "${var.aws_key_name}"
  associate_public_ip_address = false
  subnet_id = "${aws_subnet.subnet-5.id}"
  vpc_security_group_ids = ["${aws_security_group.security_group_1.id}"]
  root_block_device {
    volume_type = "gp2"
    volume_size = "10"
    delete_on_termination = "true"
  }
  tags {
    Name = "Cyber-demo-qa"
    CreatedBy= "Dilip"
    RequestedBy= "Naga"
    Project= "h2ng"
    Project-Manager= "Narayan"
  }
  lifecycle {
      create_before_destroy = false
    }
}



resource "aws_instance" "Axitea-qa" {
  ami = "ami-0ff662a8c231c194c"

   disable_api_termination = "true"

instance_type = "t2.medium"
  availability_zone = "eu-west-1b"
  key_name = "${var.aws_key_name}"
  associate_public_ip_address = false
  subnet_id = "${aws_subnet.subnet-5.id}"
  vpc_security_group_ids = ["${aws_security_group.security_group_1.id}"]
  root_block_device {
    volume_type = "gp2"
    volume_size = "10"
    delete_on_termination = "true"
  }
  tags {
    Name = "Axitea-qa"
    CreatedBy= "Dilip"
    RequestedBy= "Naga"
    Project= "h2ng"
    Project-Manager= "Narayan"
  }
  lifecycle {
      create_before_destroy = false
    }
}



resource "aws_instance" "data-pal-qa" {
  ami = "ami-0ff662a8c231c194c"

   disable_api_termination = "true"

instance_type = "t2.medium"
  availability_zone = "eu-west-1b"
  key_name = "${var.aws_key_name}"
  associate_public_ip_address = false
  subnet_id = "${aws_subnet.subnet-5.id}"
  vpc_security_group_ids = ["${aws_security_group.security_group_1.id}"]
  root_block_device {
    volume_type = "gp2"
    volume_size = "30"
    delete_on_termination = "true"
  }
  tags {
    Name = "data-pal-qa"
    CreatedBy= "Dilip"
    RequestedBy= "Naga"
    Project= "h2ng"
    Project-Manager= "Narayan"
  }
  lifecycle {
      create_before_destroy = false
    }
}


resource "aws_instance" "bw-bank-qa" {
  ami = "ami-0ff662a8c231c194c"

   disable_api_termination = "true"

instance_type = "t2.medium"
#  availability_zone = "eu-west-1b"
  key_name = "${var.aws_key_name}"
  associate_public_ip_address = false
  subnet_id = "${aws_subnet.subnet-5.id}"
  vpc_security_group_ids = ["${aws_security_group.security_group_1.id}"]
  root_block_device {
    volume_type = "gp2"
    volume_size = "10"
    delete_on_termination = "true"
  }
  tags {
    Name = "bw-bank-qa"
	CreatedBy= "Dilip"
    RequestedBy= "Naga"
    Project= "h2ng"
    Project-Manager= "Narayan"
  }
  lifecycle {
      create_before_destroy = false
    }
}




resource "aws_instance" "Metlife-qa" {
  ami = "ami-0ff662a8c231c194c"

   disable_api_termination = "true"

instance_type = "t2.medium"
  availability_zone = "eu-west-1b"
  key_name = "${var.aws_key_name}"
  associate_public_ip_address = false
  subnet_id = "${aws_subnet.subnet-5.id}"
  vpc_security_group_ids = ["${aws_security_group.security_group_1.id}"]
  root_block_device {
    volume_type = "gp2"
    volume_size = "10"
    delete_on_termination = "true"
  }
  tags {
    Name = "Metlife-qa"
	CreatedBy= "Dilip"
    RequestedBy= "Naga"
    Project= "h2ng"
    Project-Manager= "Narayan"

  }
  lifecycle {
      create_before_destroy = false
    }
}
resource "aws_instance" "netflix" {
  ami = "${var.ec2_instance_ami}"
  disable_api_termination = "true"
instance_type = "m4.xlarge"
  availability_zone = "eu-west-1b"
  key_name = "${var.aws_key_name}"
  associate_public_ip_address = false
  subnet_id = "${aws_subnet.subnet-5.id}"
  vpc_security_group_ids = ["${aws_security_group.security_group_1.id}"]
  root_block_device {
    volume_type = "gp2"
    volume_size = "500"
    delete_on_termination = "true"
  }
  tags {
    Name = "netflix"
        CreatedBy= "dilip"
    RequestedBy= "ganesh"
    Project= "h2ng"
    Project-Manager= "narayan"
  }
  lifecycle {
      create_before_destroy = false
    }
}
resource "aws_instance" "master_card_node01" {
  ami = "ami-0624c959fa0b3c0e1"
  disable_api_termination = "true"
  instance_type = "m4.2xlarge"
  availability_zone = "eu-west-1b"
  key_name = "${var.aws_key_name}"
  associate_public_ip_address = false
  subnet_id = "${aws_subnet.subnet-5.id}"
  vpc_security_group_ids = ["${aws_security_group.security_group_1.id}"]
  root_block_device {
    volume_type = "gp2"
    volume_size = "50"
    delete_on_termination = "true"
  }
  tags {
    Name = "master_card_node01"
    CreatedBy= "dilip"
    RequestedBy= "keran"
    Project= "h2ng"
    Project-Manager= "narayan"
  }
  lifecycle {
      create_before_destroy = false
    }
}
resource "aws_instance" "master_card_node02" {
  ami = "ami-0624c959fa0b3c0e1"
  disable_api_termination = "true"
  instance_type = "m4.2xlarge"
  availability_zone = "eu-west-1b"
  key_name = "${var.aws_key_name}"
  associate_public_ip_address = false
  subnet_id = "${aws_subnet.subnet-5.id}"
  vpc_security_group_ids = ["${aws_security_group.security_group_1.id}"]
  root_block_device {
    volume_type = "gp2"
    volume_size = "50"
    delete_on_termination = "true"
  }
  tags {
    Name = "master_card_node02"
    CreatedBy= "dilip"
    RequestedBy= "keran"
    Project= "h2ng"
    Project-Manager= "narayan"
  }
  lifecycle {
      create_before_destroy = false
    }
}

resource "aws_instance" "master_card_node03" {
  ami = "ami-0624c959fa0b3c0e1"
  disable_api_termination = "true"
  instance_type = "m4.2xlarge"
  availability_zone = "eu-west-1b"
  key_name = "${var.aws_key_name}"
  associate_public_ip_address = false
  subnet_id = "${aws_subnet.subnet-5.id}"
  vpc_security_group_ids = ["${aws_security_group.security_group_1.id}"]
  root_block_device {
    volume_type = "gp2"
    volume_size = "50"
    delete_on_termination = "true"
  }
  tags {
    Name = "master_card_node03"
    CreatedBy= "dilip"
    RequestedBy= "keran"
    Project= "h2ng"
    Project-Manager= "narayan"
  }
  lifecycle {
      create_before_destroy = false
    }
}


resource "aws_instance" "netflix01" {
  ami = "ami-0b892ad4581719022"
  disable_api_termination = "true"
  instance_type = "m4.xlarge"
  availability_zone = "eu-west-1b"
  key_name = "${var.aws_key_name}"
  associate_public_ip_address = false
  subnet_id = "${aws_subnet.subnet-5.id}"
  vpc_security_group_ids = ["${aws_security_group.security_group_1.id}"]
  root_block_device {
    volume_type = "gp2"
    volume_size = "100"
    delete_on_termination = "true"
  }
  tags {
    Name = "netflix01"
    CreatedBy= "dilip"
    RequestedBy= "keran"
    Project= "h2ng"
    Project-Manager= "narayan"
  }
  lifecycle {
      create_before_destroy = false
    }
}


resource "aws_instance" "h2ng-2-ui" {
  ami = "ami-0813437e99e415830"
  disable_api_termination = "true"
  instance_type = "t2.medium"
  availability_zone = "eu-west-1b"
  key_name = "${var.aws_key_name}"
  associate_public_ip_address = false
  subnet_id = "${aws_subnet.subnet-5.id}"
  vpc_security_group_ids = ["${aws_security_group.security_group_1.id}"]
  root_block_device {
    volume_type = "gp2"
    volume_size = "20"
    delete_on_termination = "true"
  }
  tags {
    Name = "h2ng-2-ui"
    CreatedBy= "dilip"
    RequestedBy= "kiran"
    Project= "h2ng-ui"
    Project-Manager= "narayan"
  }
  lifecycle {
      create_before_destroy = false
    }
}









