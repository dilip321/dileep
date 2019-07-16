#security groups
resource "aws_security_group" "security_group_1" {
  name        = "h2ng-sg"
  description = "Allow inbound traffic from "
  vpc_id = "${aws_vpc.gce_vpc.id}"
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["10.223.112.0/22"]
    cidr_blocks = ["10.222.113.13/32"]
    cidr_blocks = ["10.222.112.0/25"]
    cidr_blocks = ["10.222.113.102/32"]
    cidr_blocks = ["10.64.64.0/19"]
    cidr_blocks = ["10.222.113.61/32"]
    cidr_blocks = ["10.224.113.0/26"]
    cidr_blocks = ["14.141.53.106/32"]
    cidr_blocks = ["121.240.227.93/32"]
    cidr_blocks = ["14.143.170.105/32"]
    cidr_blocks = ["49.248.113.34/32"]
    cidr_blocks = ["14.142.148.186/32"]
    cidr_blocks = ["111.93.150.58/32"]
    cidr_blocks = ["10.90.48.10/32"]
    cidr_blocks = ["10.222.113.8/32"] 
 }
 ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["10.222.113.62/32"]
    description = "Goutham"
    }
ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["10.222.113.0/24"]
    description = "from-dev-env"
}
ingress {
    from_port   = 27017
    to_port     = 27017
    protocol    = "tcp"
	cidr_blocks =  ["10.222.113.59/32"] 
	cidr_blocks =  ["10.222.113.111/32"]
	cidr_blocks =  ["10.222.113.31/32"]
	cidr_blocks =  ["10.222.113.105/32"]
	cidr_blocks =  ["10.222.113.32/32"]
	cidr_blocks =  ["10.222.113.7/32"]
	cidr_blocks =  ["10.222.113.35/32"]
	cidr_blocks =  ["10.222.113.216/32"]
    description = "for MongoDB"
}
/*
  ingress {
    from_port = 443
    to_port   = 443
    protocol  = "tcp"

    security_groups = ["sg-bd9f20c1"]
  }
*/
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["10.223.112.0/22"]
    cidr_blocks = ["169.254.169.123/32"]
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "h2ng"
  }
}

resource "aws_security_group" "security_group_2" {
  name        = "App-sg"
  description = "Allow inbound traffic from "
  vpc_id = "${aws_vpc.gce_vpc.id}"
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["10.223.112.0/22"]
    cidr_blocks = ["10.222.112.87/32"]
    cidr_blocks = ["10.222.113.8/32"]
    cidr_blocks = ["10.64.64.0/19"]
    cidr_blocks =  ["10.224.113.0/26"]
    cidr_blocks =  ["10.90.48.10/32"]
    cidr_blocks =  ["10.222.113.8/32"] 
    }
 ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["10.222.113.61/32"]
    description = "naga"
    }    
ingress {
from_port = 0
to_port   = 0
protocol  = "-1"
security_groups = ["${aws_security_group.kong-elb-sec-group.id}"]
}
/*
  ingress {
    from_port = 443
    to_port   = 443
    protocol  = "tcp"

    security_groups = ["sg-bd9f20c1"]
  }
*/
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["10.223.112.0/22"]
    cidr_blocks = ["169.254.169.123/32"]
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "App-sg"
  }
}

#security groups
resource "aws_security_group" "h2ng-alb-sec-group" {
  name        = "h2ng-alb-sec-group"
  description = "Allow inbound traffic from "
  vpc_id = "${aws_vpc.gce_vpc.id}"
   ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "TCP"
        cidr_blocks = ["0.0.0.0/0"]

}
/*
  ingress {
    from_port = 443
    to_port   = 443
    protocol  = "0"
    cidr_blocks = ["0.0.0.0/0"]
  }
*/
    egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "h2ng-alb-sec-group"
  }
}

#security groups
resource "aws_security_group" "kong-elb-sec-group" {
  name        = "kong-elb-sec-group"
  description = "Allow inbound traffic from "
  vpc_id = "${aws_vpc.gce_vpc.id}"
   ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "TCP"
        cidr_blocks = ["0.0.0.0/0"]

}

  ingress {
    from_port = 443
    to_port   = 443
    protocol  = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

    egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "kong-elb-sec-group"
  }
}

#security groups
resource "aws_security_group" "rule-engine-elb-sec-group" {
  name        = "rule-engine-elb-sec-group"
  description = "Allow inbound traffic from "
  vpc_id = "${aws_vpc.gce_vpc.id}"
   ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "TCP"
        cidr_blocks = ["0.0.0.0/0"]

}

  ingress {
    from_port = 443
    to_port   = 443
    protocol  = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

    egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "rule-engine-elb-sec-group"
  }
}
