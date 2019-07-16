resource "aws_route53_zone" "QA" {
  name = "qa.affinionservices.com"

  tags = {
    Environment = "QA"
  }
}
 resource "aws_route53_record" "rule-engine" {
  zone_id = "${aws_route53_zone.QA.zone_id}"
  name    = "rule-engine"
  type    = "A"

  alias {
    name                   = "${aws_alb.rule-engine-alb.dns_name}"
    zone_id                = "${aws_alb.rule-engine-alb.zone_id}"
    evaluate_target_health = false
  }
}
resource "aws_route53_record" "api" {
 zone_id = "${aws_route53_zone.QA.zone_id}"
 name    = "api"
 type    = "A"

 alias {
   name                   = "${aws_elb.kong-qa-elb1.dns_name}"
   zone_id                = "${aws_elb.kong-qa-elb1.zone_id}"
   evaluate_target_health = false
 }
}
resource "aws_route53_record" "keycloak" {
 zone_id = "${aws_route53_zone.QA.zone_id}"
 name    = "keycloak"
 type    = "A"

 alias {
   name                   = "${aws_alb.alb_front.dns_name}"
   zone_id                = "${aws_alb.alb_front.zone_id}"
   evaluate_target_health = false
 }
}

resource "aws_route53_record" "cert_validation" {
  name    = "${aws_acm_certificate.cert.domain_validation_options.0.resource_record_name}"
  type    = "${aws_acm_certificate.cert.domain_validation_options.0.resource_record_type}"
  zone_id = "${aws_route53_zone.QA.zone_id}"
  records = ["${aws_acm_certificate.cert.domain_validation_options.0.resource_record_value}"]
  ttl     = 60
}

resource "aws_route53_record" "cybersecurity" {
  zone_id = "${aws_route53_zone.QA.zone_id}"
  name    = "cybersecurity"
  type    = "A"

  alias {
    name                   = "${aws_alb.cyber-alb.dns_name}"
    zone_id                = "${aws_alb.cyber-alb.zone_id}"
    evaluate_target_health = false
  }

}

resource "aws_route53_record" "api-int" {
  zone_id = "${aws_route53_zone.QA.zone_id}"
  name    = "api-int"
  type    = "A"

  alias {
    name                   = "${aws_elb.api-int-qa-alb.dns_name}"
    zone_id                = "${aws_elb.api-int-qa-alb.zone_id}"
    evaluate_target_health = false
  }

}


resource "aws_route53_record" "com-hem" {
  zone_id = "${aws_route53_zone.QA.zone_id}"
  name    = "com-hem"
  type    = "A"

  alias {
    name                   = "${aws_elb.Com-hem-elb.dns_name}"
    zone_id                = "${aws_elb.Com-hem-elb.zone_id}"
    evaluate_target_health = false
  }

}


resource "aws_route53_record" "Baywalk" {
  zone_id = "${aws_route53_zone.QA.zone_id}"
  name    = "Baywalk"
  type    = "A"

  alias {
    name                   = "${aws_elb.Baywalk-alb-qa.dns_name}"
    zone_id                = "${aws_elb.Baywalk-alb-qa.zone_id}"
    evaluate_target_health = false
  }

}

resource "aws_route53_record" "allianz" {
  zone_id = "${aws_route53_zone.QA.zone_id}"
  name    = "allianz"
  type    = "A"

  alias {
    name                   = "${aws_alb.allianz-alb-qa.dns_name}"
    zone_id                = "${aws_alb.allianz-alb-qa.zone_id}"
    evaluate_target_health = false
  }

}

resource "aws_route53_record" "cyberdemo" {
  zone_id = "${aws_route53_zone.QA.zone_id}"
  name    = "cyberdemo"
  type    = "A"

  alias {
    name                   = "${aws_elb.cyber-demo-elb-qa.dns_name}"
    zone_id                = "${aws_elb.cyber-demo-elb-qa.zone_id}"
    evaluate_target_health = false
  }

}


resource "aws_route53_record" "de-cyberprotection" {
  zone_id = "${aws_route53_zone.QA.zone_id}"
  name    = "de-cyberprotection"
  type    = "A"

  alias {
    name                   = "${aws_elb.cyber-demo-elb-qa.dns_name}"
    zone_id                = "${aws_elb.cyber-demo-elb-qa.zone_id}"
    evaluate_target_health = false
  }

}


resource "aws_route53_record" "fr-cyberprotection" {
  zone_id = "${aws_route53_zone.QA.zone_id}"
  name    = "fr-cyberprotection"
  type    = "A"

  alias {
    name                   = "${aws_elb.cyber-demo-elb-qa.dns_name}"
    zone_id                = "${aws_elb.cyber-demo-elb-qa.zone_id}"
    evaluate_target_health = false
  }

}

resource "aws_route53_record" "it-cyberprotection" {
  zone_id = "${aws_route53_zone.QA.zone_id}"
  name    = "it-cyberprotection"
  type    = "A"

  alias {
    name                   = "${aws_elb.cyber-demo-elb-qa.dns_name}"
    zone_id                = "${aws_elb.cyber-demo-elb-qa.zone_id}"
    evaluate_target_health = false
  }

}





resource "aws_route53_record" "se-cyberprotection" {
  zone_id = "${aws_route53_zone.QA.zone_id}"
  name    = "se-cyberprotection"
  type    = "A"

  alias {
    name                   = "${aws_elb.cyber-demo-elb-qa.dns_name}"
    zone_id                = "${aws_elb.cyber-demo-elb-qa.zone_id}"
    evaluate_target_health = false
  }

}

resource "aws_route53_record" "tr-cyberprotection" {
  zone_id = "${aws_route53_zone.QA.zone_id}"
  name    = "tr-cyberprotection"
  type    = "A"

  alias {
    name                   = "${aws_elb.cyber-demo-elb-qa.dns_name}"
    zone_id                = "${aws_elb.cyber-demo-elb-qa.zone_id}"
    evaluate_target_health = false
  }

}


resource "aws_route53_record" "uk-cyberprotection" {
  zone_id = "${aws_route53_zone.QA.zone_id}"
  name    = "uk-cyberprotection"
  type    = "A"

  alias {
    name                   = "${aws_elb.cyber-demo-elb-qa.dns_name}"
    zone_id                = "${aws_elb.cyber-demo-elb-qa.zone_id}"
    evaluate_target_health = false
  }

}



resource "aws_route53_record" "bw-bank" {
  zone_id = "${aws_route53_zone.QA.zone_id}"
  name    = "bw-bank"
  type    = "A"

  alias {
    name                   = "${aws_alb.bw-bank-qa.dns_name}"
    zone_id                = "${aws_alb.bw-bank-qa.zone_id}"
    evaluate_target_health = false
  }

}


resource "aws_route53_record" "axitea" {
  zone_id = "${aws_route53_zone.QA.zone_id}"
  name    = "axitea"
  type    = "A"

  alias {
    name                   = "${aws_elb.axitea-elb-qa.dns_name}"
    zone_id                = "${aws_elb.axitea-elb-qa.zone_id}"
    evaluate_target_health = false
  }

}


resource "aws_route53_record" "metlife" {
  zone_id = "${aws_route53_zone.QA.zone_id}"
  name    = "metlife"
  type    = "A"

  alias {
    name                   = "${aws_alb.metlife-ALB-qa.dns_name}"
    zone_id                = "${aws_alb.metlife-ALB-qa.zone_id}"
    evaluate_target_health = false
  }

}
resource "aws_route53_record" "engage" {
  zone_id = "${aws_route53_zone.QA.zone_id}"
  name    = "engage"
  type    = "A"

  alias {
    name                   = "${aws_elb.h2ng-engage-qa-ui-elb.dns_name}"
    zone_id                = "${aws_elb.h2ng-engage-qa-ui-elb.zone_id}"
    evaluate_target_health = false
  }

}


resource "aws_route53_record" "mastercard" {
  zone_id = "${aws_route53_zone.QA.zone_id}"
  name    = "${var.cdn_domain_name}"
  type    = "A"

  alias = {
    name                   = "${aws_cloudfront_distribution.s3_distribution.domain_name}"
    zone_id                = "${aws_cloudfront_distribution.s3_distribution.hosted_zone_id}"
    evaluate_target_health = false
  }
}
