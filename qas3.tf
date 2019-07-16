variable "s3_bucket_name" {
type = "list"
default = ["qa-lemda-kong", "qa-files-kong","communicationtemplate-qa", "communicationprocessedtemplate-qa", "helix-audit-data-qa"]
}

resource "aws_s3_bucket" "qa-bucket" {
count = "${length(var.s3_bucket_name)}"
bucket = "${element(var.s3_bucket_name, count.index)}"
acl = "private"
force_destroy = "true"
}
