provider "aws" {
  alias = "dev"
  region  = "${var.region}"
  profile = "${var.dev_profile}"
}

resource "aws_iam_policy" "fingerprinting_code_commit" {
    provider    =   "aws.dev"
    name        =   "fingerprinting_code_commit"
    description =   "This policy is to provide code commit access to fingerprinting repository"
    policy      =   "${file("fingerprinting_code_commit_policy.json")}"
}