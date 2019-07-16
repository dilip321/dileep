terraform {
required_version = "0.11.13"
#access_key = "${var.access_key}"
#secret_key = "${var.secret_key}"
backend "s3" {
  bucket = "terraformnew-statefile"
  dynamodb_table = "terraform-state-lock-dynamo-new"
  key = "root/terraform/terraform.tfstate"
  region = "eu-west-1"
  encrypt = "true"
  profile = "default"
  }
}
