resource "aws_acm_certificate" "cert" {
  domain_name       = "qa.affinionservices.com"
  subject_alternative_names = ["*.qa.affinionservices.com"]
  validation_method = "DNS"

  tags = {
    Environment = "QA"
  }

  lifecycle {
    create_before_destroy = true
  }
}
