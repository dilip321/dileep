#variable "access_key" {}
#variable "secret_key" {}

variable "dev_profile" {
  description = "AWS Profile"
  default     = "dev"
}
variable "region" {
  default = "eu-west-1"
}
variable "profile" {
    description = "AWS credentials profile you want to use"
}
variable "aws_key_name" {
  default = "mongo-qa"
}
variable "vpc_cidr_block" {
  default = "10.223.112.0/22"
}
variable "subnet1_cidr_block" {
  default = "10.223.112.64/26"
}
variable "subnet2_cidr_block" {
  default = "10.223.112.0/26"
}
variable "subnet3_cidr_block" {
  default = "10.223.114.128/25"
}
variable "subnet4_cidr_block" {
  default = "10.223.113.0/25"
}
variable "subnet5_cidr_block" {
  default = "10.223.113.128/25"
}
variable "subnet6_cidr_block" {
  default = "10.223.114.0/25"
}
variable "subnet7_cidr_block" {
  default = "10.223.112.128/25"
}
variable "subnet8_cidr_block" {
  default = "10.223.115.0/25"
}
variable "subnet9_cidr_block" {
  default = "10.223.115.128/25"
}
variable "ec2_instance_ami" {
  default = "ami-076569036523333ee"
}
variable "aws_region" {
  default = "eu-west-1"
}
variable "target_id" {
  default = "i-04c12e34f1f70f28c"
}
variable "transdb_pwd" {}

variable "transdb_username" {}

variable "transdb_name" {}

variable "CSR1" {}

variable "CSR2" {}

variable "kongdb_pwd" {}

variable "kongdb_name" {}

variable "kongdb_username" {}

variable "tunnel1" {}
variable "tunnel2" {}
variable "tunnel1-a" {}
variable "tunnel2-a" {}


variable "user_name" {
  type = "list"
  default = ["spadala@affiniongroup.com","ygaonkar@affiniongroup.com","gmahajan@affiniongroup.com"]
}

variable "h2ng_qa_user" {
  type  = "list"
  default = ["pdeotale@affiniongroup.com","akarale@affiniongroup.com","ukarounakara@affiniongroup.com","bkulkarni@affiniongroup.com","smahadevan@tavisca.com","samore@affiniongroup.com","apandurang@affiniongroup.com","vpatel@affiniongroup.com","sushukla@tavisca.com","atalwar@affiniongroup.com","stambade@affiniongroup.com","ashtiwari@tavisca.com","stiwari@affiniongroup.com","rvamsi@affiniongroup.com"]
}

variable "h2ng_grp_name" {
  default = "h2ng_qa_group"
  description = "Group name."
}

variable "path" {
  description = "Path in which to create the group."
  default     = "/"
}

variable "policy_arns" {
  description = "Policy ARNs to attach."
  default     = ["arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess","arn:aws:iam::aws:policy/CloudWatchLogsReadOnlyAccess","arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess","arn:aws:iam::aws:policy/IAMUserChangePassword"]
}

/*
variable "membership" {
  description = "Users to add to group as members."
  default     = []
}*/


variable "website_bucket_name" {
  default = "mastercard-content.qa.affinionservices.com"
}

variable "aws_iam_instance_profile" {
  default = "instance_profile"
}

variable "domain_name" {
  default = "mastercard-content.qa.affinionservices.com"
}

variable "cdn_domain_name" {
  default = "mastercard-content"
}
