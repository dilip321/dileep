resource "aws_db_instance" "RDS-01" {
  allocated_storage    = 100
  storage_type         = "gp2"
  engine               = "postgres"
  engine_version       = "10.6"
  instance_class       = "db.t2.medium"
  identifier           = "transdb"
  name                 = "${var.transdb_name}"
  username             = "${var.transdb_username}"
  password             = "${var.transdb_pwd}"
  port                 = "5432"
  backup_retention_period    = "7"
  backup_window              = "22:12-22:42"
  maintenance_window         = "tue:03:53-tue:04:23"
  apply_immediately          = true
  db_subnet_group_name = "hadoop-qa-test"
  parameter_group_name = "default.postgres10"
  auto_minor_version_upgrade = true
  final_snapshot_identifier = "final-snapshot-mysql-4-10-2019"
  multi_az  = true
  storage_encrypted = true
 vpc_security_group_ids = ["${aws_security_group.transdb.id}"]
}

resource "aws_security_group" "transdb" {

  description = "Allow inbound traffic from "
  vpc_id = "${aws_vpc.gce_vpc.id}"
  name = "transdb_sg"

  ingress {

   from_port   = 0
   to_port     = 0
   protocol    = -1
   cidr_blocks = ["10.223.112.0/22"]
   cidr_blocks = ["10.222.113.102/32"]
   cidr_blocks = ["10.222.112.0/23"]
   cidr_blocks = ["10.222.108.0/22"]
   cidr_blocks =  ["10.90.48.10/32"]



  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags {
    Name = "transdb_sg"
  }
}

resource "aws_db_instance" "kongdb" {

  instance_class       = "db.t2.medium"
  identifier           = "kongdb"
  apply_immediately          = true
  db_subnet_group_name = "hadoop-qa-test"
  parameter_group_name = "default.postgres9.6"
  auto_minor_version_upgrade = true
  multi_az  = false
  storage_encrypted = true
 vpc_security_group_ids = ["${aws_security_group.kongdb.id}"]
 snapshot_identifier  = "arn:aws:rds:eu-west-1:234218843518:snapshot:kongdb-snapshot-final-4-9-2019"
 skip_final_snapshot  = true

}

resource "aws_security_group" "kongdb" {

  description = "Allow inbound traffic from "
  vpc_id = "${aws_vpc.gce_vpc.id}"
  name = "kongdb_sg"

  ingress {

   from_port   = 0
   to_port     = 0
   protocol    = -1

   cidr_blocks = ["10.222.113.60/32"]
   cidr_blocks = ["10.222.113.15/32"]
   cidr_blocks = ["10.222.112.87/32"]
   cidr_blocks = ["10.222.113.8/32"]
   cidr_blocks =  ["10.90.48.10/32"]


  }

  ingress {

   from_port   = 5432
   to_port     = 5432
   protocol    = "TCP"


   cidr_blocks = ["10.223.112.0/22"]



  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags {
    Name = "kongdb_sg"
  }
}
