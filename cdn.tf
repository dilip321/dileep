# AWS Cloudfront for caching
resource "aws_cloudfront_distribution" "s3_distribution" {
  origin {
    domain_name = "${aws_s3_bucket.website.bucket}.s3.amazonaws.com"
    origin_id   = "${var.domain_name}"
    
    s3_origin_config {
      origin_access_identity = "origin-access-identity/cloudfront/E3TDTURNRGFLYP"
    }
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "Managed by Atish"
  default_root_object = "index.html"

/*  logging_config {
    include_cookies = false
    bucket          = "mastercardlogs.s3.amazonaws.com"
    prefix          = "mastercardlogs"
  }*/

  aliases = ["${var.domain_name}"]

  default_cache_behavior {
    viewer_protocol_policy = "redirect-to-https"
    compress               = true
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "${var.domain_name}"

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  tags {
    Environment = "qa"
  }

  viewer_certificate {
    acm_certificate_arn = "arn:aws:acm:us-east-1:234218843518:certificate/3788c421-9e92-43c9-9004-19b005298410"
    ssl_support_method  = "sni-only"

  }
}
