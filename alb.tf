resource "aws_alb" "alb_front" {
        name            =       "keycloak"
        internal        =       false
        security_groups =       ["sg-042c7b4ae6f582371"]
        subnets         =       ["subnet-0185b4032091e513e","subnet-0b743fc64f2086779"]
        enable_deletion_protection      =       true

}
resource "aws_alb_target_group" "alb_front_https" {
        name    = "keycloak"
        vpc_id  = "vpc-071765c5f6a29c7aa"
        port    = "8080"
        protocol        = "HTTP"
        health_check {
                path = "/healthcheck"
                port = "80"
                protocol = "HTTP"
                healthy_threshold = 2
                unhealthy_threshold = 2
                interval = 5
                timeout = 4
                matcher = "200-308"
        }
}

resource "aws_elb" "keycloak-elb-qa" {
  name = "keycloak-elb-qa"
  security_groups =      ["${aws_security_group.kong-elb-sec-group.id}"]
  subnets         =      ["${aws_subnet.subnet-1.id}","${aws_subnet.subnet-2.id}"]
  internal        = true
  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 3
    interval = 30
    target = "TCP:8443"
  }
  listener {
    lb_port = 443
    lb_protocol = "HTTPS"
    instance_port = "8443"
    instance_protocol = "HTTP"
    ssl_certificate_id ="${aws_acm_certificate.cert.arn}"

  }
  instances                   = ["${aws_instance.instance23.id}"]
  cross_zone_load_balancing   = true
  idle_timeout                = 60
    tags = {
    Name = "keycloak-elb-qa"
  }
}



#resource "aws_alb_target_group_attachment" "alb_backend-01_http" {
#  target_group_arn = "arn:aws:elasticloadbalancing:eu-west-1:234218843518:targetgroup/keycloak/b3e525732ca877d3"
#  target_id        = "${var.target_id}"
#  port             = 80
#}

resource "aws_alb" "cyber-alb" {
        name            =       "cyber-alb"
        internal        =       false
        security_groups  = ["${aws_security_group.h2ng-alb-sec-group.id}"]
        subnets         =      ["${aws_subnet.subnet-1.id}","${aws_subnet.subnet-2.id}"]
        enable_deletion_protection      =       false

}


resource "aws_alb_target_group" "benifit-feature-members-target-group" {
        name    = "benifit-feature-members-tgt-grp"
        vpc_id = "${aws_vpc.gce_vpc.id}"
        port    = "80"
        protocol        = "HTTP"
        health_check {
                path = "/"
                port = "traffic-port"
                protocol = "HTTP"
                healthy_threshold = 2
                unhealthy_threshold = 2
                interval = 10
                timeout = 5
                matcher = "200,404"
        }
}


resource "aws_alb_target_group_attachment" "benifit-feature-members-tg-attach" {
  target_group_arn = "${aws_alb_target_group.benifit-feature-members-target-group.arn}"
  target_id        =  "${aws_instance.cyber.id}"
  port             = 8051

}


resource "aws_alb_listener" "benifit-feature-members_listener" {
  load_balancer_arn = "${aws_alb.cyber-alb.arn}"
  port              = 80
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_alb_target_group.benifit-feature-members-target-group.arn}"
    type             = "forward"
  }
}

resource "aws_alb_listener_rule" "benifit-feature-members-list_rule" {
  listener_arn = "${aws_alb_listener.benifit-feature-members_listener.arn}"
  priority     = 38

  action {
    type             = "forward"
    target_group_arn = "${aws_alb_target_group.benifit-feature-members-target-group.arn}"
  }

    condition {
    field  = "path-pattern"
    values = ["/rest/*"]
  }
}


 resource "aws_elb" "kong-qa-elb1" {
  name = "kong-qa-elb1"
  security_groups =      ["${aws_security_group.kong-elb-sec-group.id}"]
  subnets         =      ["${aws_subnet.subnet-1.id}","${aws_subnet.subnet-2.id}"]
  cross_zone_load_balancing   = true
  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 3
    interval = 30
    target = "TCP:8000"
  }
  listener {
    lb_port = 443
    lb_protocol = "HTTPS"
    instance_port = "8000"
    instance_protocol = "HTTP"
    ssl_certificate_id ="${aws_acm_certificate.cert.arn}"

  }
  instances                   = ["${aws_instance.instance20.id}"]
  cross_zone_load_balancing   = true
  idle_timeout                = 60
    tags = {
    Name = "kong-qa-elb1"
  }
}

resource "aws_alb" "rule-engine-alb" {
        name            =       "rule-engine-alb"
        internal        =       false
        security_groups  = ["${aws_security_group.rule-engine-elb-sec-group.id}"]
        subnets         =      ["${aws_subnet.subnet-1.id}","${aws_subnet.subnet-2.id}"]
        enable_deletion_protection      =       true

}


resource "aws_alb_target_group" "rule-engine-target-group" {
        name    = "rule-engine-target-group"
        vpc_id = "${aws_vpc.gce_vpc.id}"
        port    = "8080"
        protocol        = "HTTP"
        health_check {
                path = "/"
                port = "traffic-port"
                protocol = "HTTP"
                healthy_threshold = 2
                unhealthy_threshold = 2
                interval = 10
                timeout = 5
                matcher = "200,404"
        }
}


resource "aws_alb_target_group_attachment" "rule-engine-tg-attach" {
  target_group_arn = "${aws_alb_target_group.rule-engine-target-group.arn}"
  target_id        = "${aws_instance.instance19.id}"
  port             = 8080

}
 resource "aws_alb_listener" "rule-engine_listener" {
  load_balancer_arn = "${aws_alb.rule-engine-alb.arn}"
  port              = 443
  protocol          = "HTTPS"
  certificate_arn = "${aws_acm_certificate.cert.arn}"


  default_action {
    target_group_arn = "${aws_alb_target_group.rule-engine-target-group.arn}"
    type             = "forward"
  }
}

resource "aws_lb_listener_certificate" "rule-engine" {
  listener_arn    = "${aws_alb_listener.rule-engine_listener.arn}"
  certificate_arn = "${aws_acm_certificate.cert.arn}"
}

#resource "aws_alb_listener_rule" "rule-engine-list_rule" {
#  listener_arn = "${aws_alb_listener.rule-engine_listener.arn}"
#  priority     = 1

#  action {
#    type             = "forward"
#    target_group_arn = "${aws_alb_target_group.rule-engine-target-group.arn}"
#  }
#    condition {
#    field  = "path-pattern"
#    values = ["*"]
#  }
#}

resource "aws_alb_target_group" "benefits-core-com-service-qa" {
        name    = "benefits-core-com-service-qa"
        vpc_id = "${aws_vpc.gce_vpc.id}"
        port    = "8086"
        protocol        = "HTTP"
        health_check {
                path = "/"
                port = "traffic-port"
                protocol = "HTTP"
                healthy_threshold = 2
                unhealthy_threshold = 2
                interval = 10
                timeout = 5
                matcher = "200,404"
        }
}

  resource "aws_alb_target_group_attachment" "benefits-core-com-service-qa-tg-attach" {
  target_group_arn = "${aws_alb_target_group.benefits-core-com-service-qa.arn}"
  target_id        = "${aws_instance.cyber.id}"
  port             = 8091

}
#  resource "aws_alb_listener" "benefits-core-com-service-qa_listener" {
#  load_balancer_arn = "${aws_alb.benifi.arn}"
#  port              = 80
#  protocol          = "HTTP"

#  default_action {
#    target_group_arn = "${aws_alb_target_group.benefits-core-com-service-qa.arn}"
#    type             = "forward"
#  }

/*resource "aws_alb_listener_rule" "benefits-core-com-service-qa_rule" {
  listener_arn = "${aws_alb_listener.benifit-feature-members_listener.arn}"
  priority     = 18

  action {
    type             = "forward"
    target_group_arn = "${aws_alb_target_group.benefits-core-com-service-qa.arn}"
  }

  condition {
    field  = "path-pattern"
    values = ["/api/communication/*"]
  }
}*/


resource "aws_alb_target_group" "benifits-core-comm-event" {
        name    = "benifits-core-comm-event"
        vpc_id = "${aws_vpc.gce_vpc.id}"
        port    = "80"
        protocol        = "HTTP"
        health_check {
                path = "/"
                port = "traffic-port"
                protocol = "HTTP"
                healthy_threshold = 2
                unhealthy_threshold = 2
                interval = 10
                timeout = 5
                matcher = "200,404"
        }
}

  resource "aws_alb_target_group_attachment" "benifits-core-comm-event-tg-attach" {
  target_group_arn = "${aws_alb_target_group.benifits-core-comm-event.arn}"
  target_id        =  "${aws_instance.cyber.id}"
  port             = 8700

}
#  resource "aws_alb_listener" "benifits-core-comm-event_listener" {
#  load_balancer_arn = "${aws_alb.benifit-feature-members-alb.arn}"
#  port              = 80
#  protocol          = "HTTP"

#  default_action {
#    target_group_arn = "${aws_alb_target_group.benefits-core-com-service-qa.arn}"
#    type             = "forward"
#  }

resource "aws_alb_listener_rule" "benifits-core-comm-event_rule" {
  listener_arn = "${aws_alb_listener.benifit-feature-members_listener.arn}"
  priority     = 8

  action {
    type             = "forward"
    target_group_arn = "${aws_alb_target_group.benifits-core-comm-event.arn}"
  }

  condition {
    field  = "path-pattern"
    values = ["/communication-event/*"]
  }
}





resource "aws_alb_target_group" "benifits-cs-alrts-cb-service" {
        name    = "benifits-cs-alrts-cb-service"
        vpc_id = "${aws_vpc.gce_vpc.id}"
        port    = "80"
        protocol        = "HTTP"
        health_check {
                path = "/"
                port = "traffic-port"
                protocol = "HTTP"
                healthy_threshold = 2
                unhealthy_threshold = 2
                interval = 10
                timeout = 5
                matcher = "200,404"
        }
}

  resource "aws_alb_target_group_attachment" "benifits-cs-alrts-cb-service-tg-attach" {
  target_group_arn = "${aws_alb_target_group.benifits-cs-alrts-cb-service.arn}"
  target_id        =  "${aws_instance.cyber.id}"
  port             = 8087

}
#  resource "aws_alb_listener" "benifits-core-communication-event_listener" {
#  load_balancer_arn = "${aws_alb.benifit-feature-members-alb.arn}"
#  port              = 80
#  protocol          = "HTTP"

#  default_action {
#    target_group_arn = "${aws_alb_target_group.benefits-core-com-service-qa.arn}"
#    type             = "forward"
#  }

resource "aws_alb_listener_rule" "benifits-cs-alrts-cb-service_rule" {
  listener_arn = "${aws_alb_listener.benifit-feature-members_listener.arn}"
  priority     = 15

  action {
    type             = "forward"
    target_group_arn = "${aws_alb_target_group.benifits-cs-alrts-cb-service.arn}"
  }

  condition {
    field  = "path-pattern"
    values = ["/rest/kafka/v1*"]


  }
}


resource "aws_alb_target_group" "benifits-feature-activities" {
        name    = "benifits-feature-activities"
        vpc_id = "${aws_vpc.gce_vpc.id}"
        port    = "80"
        protocol        = "HTTP"
        health_check {
                path = "/"
                port = "traffic-port"
                protocol = "HTTP"
                healthy_threshold = 2
                unhealthy_threshold = 2
                interval = 10
                timeout = 5
                matcher = "200,404"
        }
}

  resource "aws_alb_target_group_attachment" "bbenifits-feature-activities-tg-attach" {
  target_group_arn = "${aws_alb_target_group.benifits-feature-activities.arn}"
  target_id        =  "${aws_instance.cyber.id}"
  port             = 8086

}
#  resource "aws_alb_listener" "benifits-core-communication-event_listener" {
#  load_balancer_arn = "${aws_alb.benifit-feature-members-alb.arn}"
#  port              = 80
#  protocol          = "HTTP"

#  default_action {
#    target_group_arn = "${aws_alb_target_group.benifits-feature-activities.arn}"
#    type             = "forward"
#  }

resource "aws_alb_listener_rule" "benifits-feature-activities" {
  listener_arn = "${aws_alb_listener.benifit-feature-members_listener.arn}"
  priority     = 16

  action {
    type             = "forward"
    target_group_arn = "${aws_alb_target_group.benifits-feature-activities.arn}"
  }

  condition {
    field  = "path-pattern"
    values = ["/core/activities/*"]

  }
}

resource "aws_alb_listener_rule" "benifits-feature-activities2" {
  listener_arn = "${aws_alb_listener.benifit-feature-members_listener.arn}"
  priority     = 17

  action {
    type             = "forward"
    target_group_arn = "${aws_alb_target_group.benifits-feature-activities.arn}"
  }

  condition {
    field  = "path-pattern"
    values = ["/core/requests/v1/*"]

  }
}



resource "aws_alb_target_group" "benefits-feature-service-request" {
        name    = "benefits-feature-service-request"
        vpc_id = "${aws_vpc.gce_vpc.id}"
        port    = "80"
        protocol        = "HTTP"
        health_check {
                path = "/"
                port = "traffic-port"
                protocol = "HTTP"
                healthy_threshold = 2
                unhealthy_threshold = 2
                interval = 10
                timeout = 5
                matcher = "200,404"
        }
}

  resource "aws_alb_target_group_attachment" "benefits-feature-service-request-tg-attach" {
  target_group_arn = "${aws_alb_target_group.benefits-feature-service-request.arn}"
  target_id        =  "${aws_instance.cyber.id}"
  port             = 8047

}
#  resource "aws_alb_listener" "benifits-core-communication-event_listener" {
#  load_balancer_arn = "${aws_alb.benifit-feature-members-alb.arn}"
#  port              = 80
#  protocol          = "HTTP"

#  default_action {
#    target_group_arn = "${aws_alb_target_group.benifits-feature-activities.arn}"
#    type             = "forward"
#  }

resource "aws_alb_listener_rule" "benefits-feature-service-request" {
  listener_arn = "${aws_alb_listener.benifit-feature-members_listener.arn}"
  priority     = 19

  action {
    type             = "forward"
    target_group_arn = "${aws_alb_target_group.benefits-feature-service-request.arn}"
  }

  condition {
    field  = "path-pattern"
    values = ["/core/service-requests/*"]
  }
}


/*resource "aws_alb_target_group" "benefits-feature-members-cyber" {
        name    = "benefits-feature-members-cyber"
        vpc_id = "${aws_vpc.gce_vpc.id}"
        port    = "80"
        protocol        = "HTTP"
        health_check {
                path = "/"
                port = "traffic-port"
                protocol = "HTTP"
                healthy_threshold = 2
                unhealthy_threshold = 2
                interval = 10
                timeout = 5
                matcher = "200,404"
        }
}
 resource "aws_alb_target_group_attachment" "benefits-feature-members-cyber-tg-attach" {
  target_group_arn = "${aws_alb_target_group.benefits-feature-members-cyber.arn}"
  target_id        =  "${aws_instance.cyber.id}"
  port             = 9094

}
#  resource "aws_alb_listener" "benefits-feature-members-cyber" {
#  load_balancer_arn = "${aws_alb.benefits-feature-members-cyber.arn}"
#  port              = 80
#  protocol          = "HTTP"

#  default_action {
#    target_group_arn = "${aws_alb_target_group.benefits-feature-members-cyber.arn}"
#    type             = "forward"
#  }

resource "aws_alb_listener_rule" "benefits-feature-members-cyber" {
  listener_arn = "${aws_alb_listener.benifit-feature-members_listener.arn}"
  priority     = 20

  action {
    type             = "forward"
    target_group_arn = "${aws_alb_target_group.benefits-feature-members-cyber.arn}"
  }

  condition {
    field  = "path-pattern"
    values = ["/rest/*"]
  }
}*/

resource "aws_alb_target_group" "benefits-feature-config-server" {
        name    = "benefits-feature-config-server"
        vpc_id = "${aws_vpc.gce_vpc.id}"
        port    = "80"
        protocol        = "HTTP"
        health_check {
                path = "/"
                port = "traffic-port"
                protocol = "HTTP"
                healthy_threshold = 2
                unhealthy_threshold = 2
                interval = 10
                timeout = 5
                matcher = "200,404"
        }
}

  resource "aws_alb_target_group_attachment" "benefits-feature-config-server" {
  target_group_arn = "${aws_alb_target_group.benefits-feature-config-server.arn}"
  target_id        =  "${aws_instance.cyber.id}"
  port             = 8888

}
#  resource "aws_alb_listener" "benefits-feature-config-server" {
#  load_balancer_arn = "${aws_alb.benifit-feature-members-alb.arn}"
#  port              = 80
#  protocol          = "HTTP"

#  default_action {
#    target_group_arn = "${aws_alb_target_group.benefits-feature-members.arn}"
#    type             = "forward"
#  }

resource "aws_alb_listener_rule" "benefits-feature-config-server" {
  listener_arn = "${aws_alb_listener.benifit-feature-members_listener.arn}"
  priority     = 3

  action {
    type             = "forward"
    target_group_arn = "${aws_alb_target_group.benefits-feature-config-server.arn}"
  }

  condition {
    field  = "path-pattern"
    values = ["/configserver/*"]
  }
}

resource "aws_alb_target_group" "benefits-cybersecurity-assets" {
        name    = "benefits-cybersecurity-assets"
        vpc_id = "${aws_vpc.gce_vpc.id}"
        port    = "80"
        protocol        = "HTTP"
        health_check {
                path = "/"
                port = "traffic-port"
                protocol = "HTTP"
                healthy_threshold = 2
                unhealthy_threshold = 2
                interval = 10
                timeout = 5
                matcher = "200,404"
        }
}

  resource "aws_alb_target_group_attachment" "benefits-cybersecurity-assets" {
  target_group_arn = "${aws_alb_target_group.benefits-cybersecurity-assets.arn}"
  target_id        =  "${aws_instance.cyber.id}"
  port             = 9095

}
#  resource "aws_alb_listener" "benefits-cybersecurity-assets" {
#  load_balancer_arn = "${aws_alb.benifit-feature-members-alb.arn}"
#  port              = 80
#  protocol          = "HTTP"

#  default_action {
#    target_group_arn = "${aws_alb_target_group.benefits-cybersecurity-assets.arn}"
#    type             = "forward"
#  }

resource "aws_alb_listener_rule" "benefits-cybersecurity-assets" {
  listener_arn = "${aws_alb_listener.benifit-feature-members_listener.arn}"
  priority     = 18

  action {
    type             = "forward"
    target_group_arn = "${aws_alb_target_group.benefits-cybersecurity-assets.arn}"
  }

  condition {
    field  = "path-pattern"
    values = ["/assets*"]
  }
}

resource "aws_alb_target_group" "benifits-core-communication" {
        name    = "benifits-core-communication"
        vpc_id = "${aws_vpc.gce_vpc.id}"
        port    = "80"
        protocol        = "HTTP"
        health_check {
                path = "/"
                port = "traffic-port"
                protocol = "HTTP"
                healthy_threshold = 2
                unhealthy_threshold = 2
                interval = 10
                timeout = 5
                matcher = "200,404"
        }
}

  resource "aws_alb_target_group_attachment" "benifits-core-communication-tg-attach" {
  target_group_arn = "${aws_alb_target_group.benifits-core-communication.arn}"
  target_id        =  "${aws_instance.cyber.id}"
  port             = 8300

}
#  resource "aws_alb_listener" "benifits-core-communication-event_listener" {
#  load_balancer_arn = "${aws_alb.benifit-feature-members-alb.arn}"
#  port              = 80
#  protocol          = "HTTP"

#  default_action {
#    target_group_arn = "${aws_alb_target_group.benefits-core-com-service-qa.arn}"
#    type             = "forward"
#  }

resource "aws_alb_listener_rule" "benifits-core-communication_rule" {
  listener_arn = "${aws_alb_listener.benifit-feature-members_listener.arn}"
  priority     = 9

  action {
    type             = "forward"
    target_group_arn = "${aws_alb_target_group.benifits-core-communication.arn}"
  }

  condition {
    field  = "path-pattern"
    values = ["/communication/*"]
  }
}

resource "aws_alb_target_group" "benefits-core-comm-merge-fields" {
        name    = "benefits-core-comm-merge-fields"
        vpc_id = "${aws_vpc.gce_vpc.id}"
        port    = "80"
        protocol        = "HTTP"
        health_check {
                path = "/"
                port = "traffic-port"
                protocol = "HTTP"
                healthy_threshold = 2
                unhealthy_threshold = 2
                interval = 10
                timeout = 5
                matcher = "200,404"
        }
}

  resource "aws_alb_target_group_attachment" "benefits-core-comm-merge-fields" {
  target_group_arn = "${aws_alb_target_group.benefits-core-comm-merge-fields.arn}"
  target_id        =  "${aws_instance.cyber.id}"
  port             = 8085

}
#  resource "aws_alb_listener" "benefits-core-communication-merge-fields_listener" {
#  load_balancer_arn = "${aws_alb.benifit-feature-members-alb.arn}"
#  port              = 80
#  protocol          = "HTTP"

#  default_action {
#    target_group_arn = "${aws_alb_target_group.benefits-core-commun-merge-fields.arn}"
#    type             = "forward"
#  }

resource "aws_alb_listener_rule" "benefits-core-comm-merge-fields_rule" {
  listener_arn = "${aws_alb_listener.benifit-feature-members_listener.arn}"
  priority     = 21

  action {
    type             = "forward"
    target_group_arn = "${aws_alb_target_group.benefits-core-comm-merge-fields.arn}"
  }

  condition {
    field  = "path-pattern"
    values = ["/benefits-core-communication-merge-fields/*"]
  }
}


resource "aws_alb_target_group" "benefits-core-membercontact" {
        name    = "benefits-core-membercontact"
        vpc_id = "${aws_vpc.gce_vpc.id}"
        port    = "80"
        protocol        = "HTTP"
        health_check {
                path = "/"
                port = "traffic-port"
                protocol = "HTTP"
                healthy_threshold = 2
                unhealthy_threshold = 2
                interval = 10
                timeout = 5
                matcher = "200,404"
        }
}

  resource "aws_alb_target_group_attachment" "benefits-core-membercontact-tg-attach" {
  target_group_arn = "${aws_alb_target_group.benefits-core-membercontact.arn}"
  target_id         = "${aws_instance.cyber.id}"
  port             = 8048

}
#  resource "aws_alb_listener" "benefits-feature-members-cyber" {
#  load_balancer_arn = "${aws_alb.benefits-feature-members-cyber.arn}"
#  port              = 80
#  protocol          = "HTTP"

#  default_action {
#    target_group_arn = "${aws_alb_target_group.benefits-feature-members-cyber.arn}"
#    type             = "forward"
#  }

resource "aws_alb_listener_rule" "benefits-core-membercontact" {
  listener_arn = "${aws_alb_listener.benifit-feature-members_listener.arn}"
  priority     = 22

  action {
    type             = "forward"
    target_group_arn = "${aws_alb_target_group.benefits-core-membercontact.arn}"
  }

  condition {
    field  = "path-pattern"
    values = ["/core/membercontact/*"]
  }
}

resource "aws_alb_target_group" "benefits-package-service" {
        name    = "benefits-package-service"
        vpc_id = "${aws_vpc.gce_vpc.id}"
        port    = "80"
        protocol        = "HTTP"
        health_check {
                path = "/"
                port = "traffic-port"
                protocol = "HTTP"
                healthy_threshold = 2
                unhealthy_threshold = 2
                interval = 10
                timeout = 5
                matcher = "200,404"
        }
}

  resource "aws_alb_target_group_attachment" "benefits-package-service-tg-attach" {
  target_group_arn = "${aws_alb_target_group.benefits-package-service.arn}"
  target_id        = "${aws_instance.cyber.id}"
  port             = 8087

}
#  resource "aws_alb_listener" "benefits-feature-members-cyber" {
#  load_balancer_arn = "${aws_alb.benefits-feature-members-cyber.arn}"
#  port              = 80
#  protocol          = "HTTP"

#  default_action {
#    target_group_arn = "${aws_alb_target_group.benefits-feature-members-cyber.arn}"
#    type             = "forward"
#  }

/*resource "aws_alb_listener_rule" "benefits-package-service" {
  listener_arn = "${aws_alb_listener.benifit-feature-members_listener.arn}"
  priority     = 24

  action {
    type             = "forward"
    target_group_arn = "${aws_alb_target_group.benefits-package-service.arn}"
  }

  condition {
    field  = "path-pattern"
    values = ["/core/benefits/*"]
  }
}*/






 resource "aws_elb" "api-int-qa-alb" {
  name = "api-int-qa-alb"
  security_groups =      ["${aws_security_group.kong-elb-sec-group.id}"]
  subnets         =      ["${aws_subnet.subnet-1.id}","${aws_subnet.subnet-2.id}"]
  internal        = true
  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 3
    interval = 30
    target = "TCP:8000"
  }
  listener {
    lb_port = 443
    lb_protocol = "HTTPS"
    instance_port = "8000"
    instance_protocol = "HTTP"
    ssl_certificate_id ="${aws_acm_certificate.cert.arn}"

  }
  instances                   = ["${aws_instance.instance20.id}"]
  cross_zone_load_balancing   = true
  idle_timeout                = 60
    tags = {
    Name = "api-int-qa-alb"
  }
}



resource "aws_alb_target_group" "benefit-content-service" {
        name    = "benefit-content-service"
        vpc_id = "${aws_vpc.gce_vpc.id}"
        port    = "80"
        protocol        = "HTTP"
        health_check {
                path = "/"
                port = "traffic-port"
                protocol = "HTTP"
                healthy_threshold = 2
                unhealthy_threshold = 2
                interval = 10
                timeout = 5
                matcher = "200,404"
        }
}

  resource "aws_alb_target_group_attachment" "benefit-content-service-tg-attach" {
  target_group_arn = "${aws_alb_target_group.benefit-content-service.arn}"
  target_id        = "${aws_instance.cyber.id}"
  port             = 8093

}
#  resource "aws_alb_listener" "benefit-content-service" {
#  load_balancer_arn = "${aws_alb.benefits-feature-members-cyber.arn}"
#  port              = 80
#  protocol          = "HTTP"

#  default_action {
#    target_group_arn = "${aws_alb_target_group.benefits-feature-members-cyber.arn}"
#    type             = "forward"
#  }

resource "aws_alb_listener_rule" "benefit-content-service" {
  listener_arn = "${aws_alb_listener.benifit-feature-members_listener.arn}"
  priority     = 23

  action {
    type             = "forward"
    target_group_arn = "${aws_alb_target_group.benefit-content-service.arn}"
  }

  condition {
    field  = "path-pattern"
    values = ["/benefit-content-api/*"]
  }
}


resource "aws_alb_target_group" "vendor-benefit-usage-service" {
        name    = "vendor-benefit-usage-service"
        vpc_id = "${aws_vpc.gce_vpc.id}"
        port    = "80"
        protocol        = "HTTP"
        health_check {
                path = "/"
                port = "traffic-port"
                protocol = "HTTP"
                healthy_threshold = 2
                unhealthy_threshold = 2
                interval = 10
                timeout = 5
                matcher = "200,404"
        }
}

  resource "aws_alb_target_group_attachment" "vendor-benefit-usage-service-tg-attach" {
  target_group_arn = "${aws_alb_target_group.vendor-benefit-usage-service.arn}"
  target_id        = "${aws_instance.cyber.id}"
  port             = 8090

}
#  resource "aws_alb_listener" "benifits-core-communication-event_listener" {
#  load_balancer_arn = "${aws_alb.benifit-feature-members-alb.arn}"
#  port              = 80
#  protocol          = "HTTP"

#  default_action {
#    target_group_arn = "${aws_alb_target_group.benifits-feature-activities.arn}"
#    type             = "forward"
#  }

resource "aws_alb_listener_rule" "vendor-benefit-usage-service" {
  listener_arn = "${aws_alb_listener.benifit-feature-members_listener.arn}"
  priority     = 24

  action {
    type             = "forward"
    target_group_arn = "${aws_alb_target_group.vendor-benefit-usage-service.arn}"
  }

  condition {
    field  = "path-pattern"
    values = ["/vendor-api/*"]
  }
}

resource "aws_alb_target_group" "Standing-data-service" {
        name    = "vStanding-data-service"
        vpc_id = "${aws_vpc.gce_vpc.id}"
        port    = "80"
        protocol        = "HTTP"
        health_check {
                path = "/"
                port = "traffic-port"
                protocol = "HTTP"
                healthy_threshold = 2
                unhealthy_threshold = 2
                interval = 10
                timeout = 5
                matcher = "200,404"
        }
}

  resource "aws_alb_target_group_attachment" "Standing-data-service-tg-attach" {
  target_group_arn = "${aws_alb_target_group.Standing-data-service.arn}"
  target_id        = "${aws_instance.cyber.id}"
  port             = 8092

}
#  resource "aws_alb_listener" "benifits-core-communication-event_listener" {
#  load_balancer_arn = "${aws_alb.benifit-feature-members-alb.arn}"
#  port              = 80
#  protocol          = "HTTP"

#  default_action {
#    target_group_arn = "${aws_alb_target_group.benifits-feature-activities.arn}"
#    type             = "forward"
#  }

resource "aws_alb_listener_rule" "Standing-data-service" {
  listener_arn = "${aws_alb_listener.benifit-feature-members_listener.arn}"
  priority     = 25

  action {
    type             = "forward"
    target_group_arn = "${aws_alb_target_group.Standing-data-service.arn}"
  }

  condition {
    field  = "path-pattern"
    values = ["/core/benefits/*"]
  }
}
resource "aws_alb_listener_rule" "benifits-cs-alrts-cb-service_rule-1" {
  listener_arn = "${aws_alb_listener.benifit-feature-members_listener.arn}"
  priority     = 6

  action {
    type             = "forward"
    target_group_arn = "${aws_alb_target_group.benifits-cs-alrts-cb-service.arn}"
  }

  condition {
    field  = "path-pattern"
    values = ["/rest/core/member/*"]


  }
}
resource "aws_alb_listener_rule" "benifits-cs-alrts-cb-service_rule-2" {
  listener_arn = "${aws_alb_listener.benifit-feature-members_listener.arn}"
  priority     = 5

  action {
    type             = "forward"
    target_group_arn = "${aws_alb_target_group.benifits-cs-alrts-cb-service.arn}"
  }

  condition {
    field  = "path-pattern"
    values = ["/rest/core/alerts/*"]

  }
}
resource "aws_alb_listener_rule" "benifits-cs-alrts-cb-service_rule-3" {
  listener_arn = "${aws_alb_listener.benifit-feature-members_listener.arn}"
  priority     = 7

  action {
    type             = "forward"
    target_group_arn = "${aws_alb_target_group.benifits-cs-alrts-cb-service.arn}"
  }

  condition {
    field  = "path-pattern"
    values = ["/rest/callback/v1*"]

  }
}
resource "aws_alb_listener_rule" "benifits-cs-alrts-cb-service_rule-4" {
  listener_arn = "${aws_alb_listener.benifit-feature-members_listener.arn}"
  priority     = 10

  action {
    type             = "forward"
    target_group_arn = "${aws_alb_target_group.benifits-cs-alrts-cb-service.arn}"
  }

  condition {
    field  = "path-pattern"
    values = ["/rest/alerts/member/v1*"]

  }
}
resource "aws_alb_listener_rule" "benifits-cs-alrts-cb-service_rule-5" {
  listener_arn = "${aws_alb_listener.benifit-feature-members_listener.arn}"
  priority     = 11

  action {
    type             = "forward"
    target_group_arn = "${aws_alb_target_group.benifits-cs-alrts-cb-service.arn}"
  }

  condition {
    field  = "path-pattern"
    values = ["/rest/alerts/details/v1*"]

  }
}
resource "aws_alb_listener_rule" "benifits-cs-alrts-cb-service_rule-6" {
  listener_arn = "${aws_alb_listener.benifit-feature-members_listener.arn}"
  priority     = 12

  action {
    type             = "forward"
    target_group_arn = "${aws_alb_target_group.benifits-cs-alrts-cb-service.arn}"
  }

  condition {
    field  = "path-pattern"
    values = ["/rest/alerts/summary/v1*"]
  }
}
resource "aws_alb_listener_rule" "benifits-cs-alrts-cb-service_rule-7" {
  listener_arn = "${aws_alb_listener.benifit-feature-members_listener.arn}"
  priority     = 13

  action {
    type             = "forward"
    target_group_arn = "${aws_alb_target_group.benifits-cs-alrts-cb-service.arn}"
  }

  condition {
    field  = "path-pattern"
    values = ["/rest/alerts/addchecklist/v1*"]
  }
}
resource "aws_alb_listener_rule" "benifits-cs-alrts-cb-service_rule-8" {
  listener_arn = "${aws_alb_listener.benifit-feature-members_listener.arn}"
  priority     = 14

  action {
    type             = "forward"
    target_group_arn = "${aws_alb_target_group.benifits-cs-alrts-cb-service.arn}"
  }

  condition {
    field  = "path-pattern"
    values = ["/rest/alerts/update/v1*"]
  }
}
resource "aws_alb_listener_rule" "benifits-cs-alrts-cb-service_rule-9" {
  listener_arn = "${aws_alb_listener.benifit-feature-members_listener.arn}"
  priority     = 15

  action {
    type             = "forward"
    target_group_arn = "${aws_alb_target_group.benifits-cs-alrts-cb-service.arn}"
  }

  condition {
    field  = "path-pattern"
    values = ["/rest/kafka/v1*"]
  }
}

resource "aws_alb" "allianz-alb-qa" {
        name            =       "allianz-alb-qa"
        internal        =       false
        security_groups  = ["${aws_security_group.rule-engine-elb-sec-group.id}"]
        subnets         =      ["${aws_subnet.subnet-1.id}","${aws_subnet.subnet-2.id}"]
        enable_deletion_protection      =       true

}


resource "aws_alb_target_group" "allianz-target-group" {
        name    = "allianz-alb-target-group"
        vpc_id = "${aws_vpc.gce_vpc.id}"
        port    = "80"
        protocol        = "HTTP"
        health_check {
                path = "/"
                port = "traffic-port"
                protocol = "HTTP"
                healthy_threshold = 2
                unhealthy_threshold = 2
                interval = 10
                timeout = 5
                matcher = "200,404"
        }
}

resource "aws_alb_target_group_attachment" "allianz-alb-target-attach" {
  target_group_arn = "${aws_alb_target_group.allianz-target-group.arn}"
  target_id        = "${aws_instance.Allianz-qa.id}"
  port             = 80

}

resource "aws_alb_listener" "allianz_listener" {
  load_balancer_arn = "${aws_alb.allianz-alb-qa.arn}"
  port              = 443
  protocol          = "HTTPS"
  certificate_arn = "${aws_acm_certificate.cert.arn}"

  default_action {
    target_group_arn = "${aws_alb_target_group.allianz-target-group.arn}"
    type             = "forward"
  }
}

resource "aws_alb_listener" "allianz_listener1" {
  load_balancer_arn = "${aws_alb.allianz-alb-qa.arn}"
  port              = 80
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_alb_target_group.allianz-target-group.arn}"
    type             = "forward"
  }
}


resource "aws_lb_listener_certificate" "allianz-qa" {
  listener_arn    = "${aws_alb_listener.allianz_listener.arn}"
  certificate_arn = "${aws_acm_certificate.cert.arn}"
}




resource "aws_elb" "Baywalk-alb-qa" {
  name = "Baywalk-alb-qa"
  security_groups =      ["${aws_security_group.kong-elb-sec-group.id}"]
  subnets         =      ["${aws_subnet.subnet-1.id}","${aws_subnet.subnet-2.id}"]
  internal        = true
  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 3
    interval = 30
    target = "TCP:80"
  }
  listener {
    lb_port = 443
    lb_protocol = "HTTPS"
    instance_port = "80"
    instance_protocol = "HTTP"
    ssl_certificate_id ="${aws_acm_certificate.cert.arn}"

  }
  listener {
    lb_port = 80
    lb_protocol = "HTTP"
    instance_port = "80"
    instance_protocol = "HTTP"
}

  instances                   = ["${aws_instance.Baywalk-qa.id}"]
  cross_zone_load_balancing   = true
  idle_timeout                = 60
    tags = {
    Name = "Baywalk-alb-qa"
  }
}

resource "aws_elb" "Com-hem-elb" {
  name = "Com-hem-elb"
  security_groups =      ["${aws_security_group.kong-elb-sec-group.id}"]
  subnets         =      ["${aws_subnet.subnet-1.id}","${aws_subnet.subnet-2.id}"]
  internal        = true
  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 3
    interval = 30
    target = "TCP:80"
  }
  listener {
    lb_port = 443
    lb_protocol = "HTTPS"
    instance_port = "80"
    instance_protocol = "HTTP"
    ssl_certificate_id ="${aws_acm_certificate.cert.arn}"

  }
  listener {
    lb_port = 80
    lb_protocol = "HTTP"
    instance_port = "80"
    instance_protocol = "HTTP"
}

  instances                   = ["${aws_instance.Com-Hem-3-1-qa.id}"]
  cross_zone_load_balancing   = true
  idle_timeout                = 60
    tags = {
    Name = "Com-hem-elb"
  }
}
resource "aws_elb" "cyber-demo-elb-qa" {
  name = "cyber-demo-elb-qa"
  security_groups =      ["${aws_security_group.kong-elb-sec-group.id}"]
  subnets         =      ["${aws_subnet.subnet-1.id}","${aws_subnet.subnet-2.id}"]
  internal        = true
  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 3
    interval = 30
    target = "TCP:80"
  }
  listener {
    lb_port = 443
    lb_protocol = "HTTPS"
    instance_port = "80"
    instance_protocol = "HTTP"
    ssl_certificate_id ="${aws_acm_certificate.cert.arn}"

  }
  listener {
    lb_port = 80
    lb_protocol = "HTTP"
    instance_port = "80"
    instance_protocol = "HTTP"
}

  instances                   = ["${aws_instance.Cyber-demo-qa.id}"]
  cross_zone_load_balancing   = true
  idle_timeout                = 60
    tags = {
    Name = "cyber-demo-elb-qa"
  }
}

resource "aws_elb" "axitea-elb-qa" {
  name = "axitea-elb-qa"
  security_groups =      ["${aws_security_group.kong-elb-sec-group.id}"]
  subnets         =      ["${aws_subnet.subnet-1.id}","${aws_subnet.subnet-2.id}"]
  internal        = true
  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 3
    interval = 30
    target = "TCP:80"
  }
  listener {
    lb_port = 443
    lb_protocol = "HTTPS"
    instance_port = "80"
    instance_protocol = "HTTP"
    ssl_certificate_id ="${aws_acm_certificate.cert.arn}"
}

  instances                   = ["${aws_instance.Axitea-qa.id}"]
  cross_zone_load_balancing   = true
  idle_timeout                = 60
    tags = {
    Name = "axitea-elb-qa"
  }
}



resource "aws_alb" "bw-bank-qa" {
        name            =       "bw-bank-qa"
        internal        =       false
        security_groups  = ["${aws_security_group.rule-engine-elb-sec-group.id}"]
        subnets         =      ["${aws_subnet.subnet-1.id}","${aws_subnet.subnet-2.id}"]
        enable_deletion_protection      =       true

}


resource "aws_alb_target_group" "bw-bank-target-group" {
        name    = "bw-bank-target-group"
        vpc_id = "${aws_vpc.gce_vpc.id}"
        port    = "80"
        protocol        = "HTTP"
        health_check {
                path = "/"
                port = "traffic-port"
                protocol = "HTTP"
                healthy_threshold = 2
                unhealthy_threshold = 2
                interval = 10
                timeout = 5
                matcher = "200,404"
        }
}

resource "aws_alb_target_group_attachment" "bw-bank-target-attach" {
  target_group_arn = "${aws_alb_target_group.bw-bank-target-group.arn}"
  target_id        = "${aws_instance.bw-bank-qa.id}"
  port             = 80

}
resource "aws_alb_listener" "bw-bank_listener" {
  load_balancer_arn = "${aws_alb.bw-bank-qa.arn}"
  port              = 443
  protocol          = "HTTPS"
  certificate_arn = "${aws_acm_certificate.cert.arn}"

  default_action {
    target_group_arn = "${aws_alb_target_group.bw-bank-target-group.arn}"
    type             = "forward"
  }
}

resource "aws_alb_listener" "bw-bank_listener1" {
  load_balancer_arn = "${aws_alb.bw-bank-qa.arn}"
  port              = 80
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_alb_target_group.bw-bank-target-group.arn}"
    type             = "forward"
  }
}


resource "aws_lb_listener_certificate" "bw-bank-qa" {
  listener_arn    = "${aws_alb_listener.bw-bank_listener.arn}"
  certificate_arn = "${aws_acm_certificate.cert.arn}"
}



resource "aws_alb" "metlife-ALB-qa" {
        name            =       "metlife-ALB-qa"
        internal        =       false
        security_groups  = ["${aws_security_group.rule-engine-elb-sec-group.id}"]
        subnets         =      ["${aws_subnet.subnet-1.id}","${aws_subnet.subnet-2.id}"]
        enable_deletion_protection      =       true

}


resource "aws_alb_target_group" "metlife-ALB-target-group" {
        name    = "metlife-ALB-target-group"
        vpc_id = "${aws_vpc.gce_vpc.id}"
        port    = "80"
        protocol        = "HTTP"
        health_check {
                path = "/"
                port = "traffic-port"
                protocol = "HTTP"
                healthy_threshold = 2
                unhealthy_threshold = 2
                interval = 10
                timeout = 5
                matcher = "200,404"
        }
}

resource "aws_alb_target_group_attachment" "metlife-target-attach" {
  target_group_arn = "${aws_alb_target_group.bw-bank-target-group.arn}"
  target_id        = "${aws_instance.Metlife-qa.id}"
  port             = 80

}
resource "aws_alb_listener" "metlife_listener" {
  load_balancer_arn = "${aws_alb.metlife-ALB-qa.arn}"
  port              = 443
  protocol          = "HTTPS"
  certificate_arn = "${aws_acm_certificate.cert.arn}"

  default_action {
    target_group_arn = "${aws_alb_target_group.metlife-ALB-target-group.arn}"
    type             = "forward"
  }
}

resource "aws_alb_listener" "metlife-ALB_listener1" {
  load_balancer_arn = "${aws_alb.metlife-ALB-qa.arn}"
  port              = 80
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_alb_target_group.metlife-ALB-target-group.arn}"
    type             = "forward"
  }
}


resource "aws_lb_listener_certificate" "metlife-qa" {
  listener_arn    = "${aws_alb_listener.metlife_listener.arn}"
  certificate_arn = "${aws_acm_certificate.cert.arn}"
}
resource "aws_alb_target_group" "benefit-mastercard-service-group" {
        name    = "benefit-mastercard-service-group"
        vpc_id = "${aws_vpc.gce_vpc.id}"
        port    = "80"
        protocol        = "HTTP"
        health_check {
                path = "/"
                port = "traffic-port"
                protocol = "HTTP"
                healthy_threshold = 2
                unhealthy_threshold = 2
                interval = 10
                timeout = 5
                matcher = "200,404"
        }
}
resource "aws_alb_target_group_attachment" "benefit-mastercard-service-tg-attach" {
  target_group_arn = "${aws_alb_target_group.benefit-mastercard-service-group.arn}"
  target_id        =  "${aws_instance.cyber.id}"
  port             = 9096

}
resource "aws_alb_listener" "benefit-mastercard-service_listener" {
  load_balancer_arn = "${aws_alb.cyber-alb.arn}"
  port              = 80
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_alb_target_group.benifit-feature-members-target-group.arn}"
    type             = "forward"
  }
}

resource "aws_alb_listener_rule" "benefit-mastercard-service-list_rule" {
  listener_arn = "${aws_alb_listener.benefit-mastercard-service_listener.arn}"
  priority     = 26

  action {
    type             = "forward"
    target_group_arn = "${aws_alb_target_group.benefit-mastercard-service-group.arn}"
  }

    condition {
    field  = "path-pattern"
    values = ["/benefit-mastercard-api/*"]
}
}
resource "aws_alb_target_group" "benefit-event-service" {
        name    = "benefit-event-service"
        vpc_id = "${aws_vpc.gce_vpc.id}"
        port    = "80"
        protocol        = "HTTP"
        health_check {
                path = "/"
                port = "traffic-port"
                protocol = "HTTP"
                healthy_threshold = 2
                unhealthy_threshold = 2
                interval = 10
                timeout = 5
                matcher = "200,404"
        }
}

  resource "aws_alb_target_group_attachment" "benefit-event-service-tg-attach" {
  target_group_arn = "${aws_alb_target_group.benefit-event-service.arn}"
  target_id        = "${aws_instance.cyber.id}"
  port             = 8098

}
#  resource "aws_alb_listener" "benifits-core-communication-event_listener" {
#  load_balancer_arn = "${aws_alb.benifit-feature-members-alb.arn}"
#  port              = 80
#  protocol          = "HTTP"

#  default_action {
#    target_group_arn = "${aws_alb_target_group.benifits-feature-activities.arn}"
#    type             = "forward"
#  }

resource "aws_alb_listener_rule" "benefit-event-service" {
  listener_arn = "${aws_alb_listener.benifit-feature-members_listener.arn}"
  priority     = 29

  action {
    type             = "forward"
    target_group_arn = "${aws_alb_target_group.benefit-event-service.arn}"
  }

  condition {
    field  = "path-pattern"
    values = ["/events/*"]
  }
}
resource "aws_alb_target_group" "benefit-history-service" {
        name    = "benefit-history-service"
        vpc_id = "${aws_vpc.gce_vpc.id}"
        port    = "80"
        protocol        = "HTTP"
        health_check {
                path = "/"
                port = "traffic-port"
                protocol = "HTTP"
                healthy_threshold = 2
                unhealthy_threshold = 2
                interval = 10
                timeout = 5
                matcher = "200,404"
        }
}
  resource "aws_alb_target_group_attachment" "benefit-history-service-tg-attach" {
  target_group_arn = "${aws_alb_target_group.benefit-history-service.arn}"
  target_id        = "${aws_instance.cyber.id}"
  port             = 9098

}
#  resource "aws_alb_listener" "benifits-core-communication-event_listener" {
#  load_balancer_arn = "${aws_alb.benifit-feature-members-alb.arn}"
#  port              = 80
#  protocol          = "HTTP"

#  default_action {
#    target_group_arn = "${aws_alb_target_group.benifits-feature-activities.arn}"
#    type             = "forward"
#  }

resource "aws_alb_listener_rule" "benefit-history-service" {
  listener_arn = "${aws_alb_listener.benifit-feature-members_listener.arn}"
  priority     = 30

  action {
    type             = "forward"
    target_group_arn = "${aws_alb_target_group.benefit-history-service.arn}"
  }

  condition {
    field  = "path-pattern"
    values = ["/history/*"]
  }
}

resource "aws_alb_target_group" "standing-data-service" {
        name    = "standing-data-service"
        vpc_id = "${aws_vpc.gce_vpc.id}"
        port    = "80"
        protocol        = "HTTP"
        health_check {
                path = "/"
                port = "traffic-port"
                protocol = "HTTP"
                healthy_threshold = 2
                unhealthy_threshold = 2
                interval = 10
                timeout = 5
                matcher = "200,404"
        }
}
  resource "aws_alb_target_group_attachment" "standing-data-service-tg-attach" {
  target_group_arn = "${aws_alb_target_group.standing-data-service.arn}"
  target_id        = "${aws_instance.cyber.id}"
  port             = 8087

}
#  resource "aws_alb_listener" "benifits-core-communication-event_listener" {
#  load_balancer_arn = "${aws_alb.benifit-feature-members-alb.arn}"
#  port              = 80
#  protocol          = "HTTP"

#  default_action {
#    target_group_arn = "${aws_alb_target_group.benifits-feature-activities.arn}"
#    type             = "forward"
#  }

resource "aws_alb_listener_rule" "standing-data-service" {
  listener_arn = "${aws_alb_listener.benifit-feature-members_listener.arn}"
  priority     = 31

  action {
    type             = "forward"
    target_group_arn = "${aws_alb_target_group.standing-data-service.arn}"
  }

  condition {
    field  = "path-pattern"
    values = ["/api/standingData/*"]
  }
}

resource "aws_alb_target_group" "benifits-cs-alerts-cb-service" {
        name    = "benifits-cs-alerts-cb-service"
        vpc_id = "${aws_vpc.gce_vpc.id}"
        port    = "80"
        protocol        = "HTTP"
        health_check {
                path = "/"
                port = "traffic-port"
                protocol = "HTTP"
                healthy_threshold = 2
                unhealthy_threshold = 2
                interval = 10
                timeout = 5
                matcher = "200,404"
        }
}

  resource "aws_alb_target_group_attachment" "benifits-cs-alerts-cb-service-tg-attach" {
  target_group_arn = "${aws_alb_target_group.benifits-cs-alerts-cb-service.arn}"
  target_id        = "${aws_instance.cyber.id}"
  port             = 9099

}
#  resource "aws_alb_listener" "benefit-content-service" {
#  load_balancer_arn = "${aws_alb.ibenefiter.arn}"
#  port              = 80
#  protocol          = "HTTP"

#  default_action {
#    target_group_arn = "${aws_alb_target_group.benefits-feber.arn}"
#    type             = "forward"
#  }

resource "aws_alb_listener_rule" "benifits-cs-alerts-cb-service" {
  listener_arn = "${aws_alb_listener.benifit-feature-members_listener.arn}"
  priority     = 32

  action {
    type             = "forward"
    target_group_arn = "${aws_alb_target_group.benifits-cs-alerts-cb-service.arn}"
  }

  condition {
    field  = "path-pattern"
    values = ["/api/alerts/*"]
  }
}
resource "aws_alb_target_group" "benifits-standing-data-service" {
        name    = "benifits-standing-data-service"
        vpc_id = "${aws_vpc.gce_vpc.id}"
        port    = "80"
        protocol        = "HTTP"
        health_check {
                path = "/"
                port = "traffic-port"
                protocol = "HTTP"
                healthy_threshold = 2
                unhealthy_threshold = 2
                interval = 10
                timeout = 5
                matcher = "200,404"
        }
}

  resource "aws_alb_target_group_attachment" "benifits-standing-data-service-tg-attach" {
  target_group_arn = "${aws_alb_target_group.benifits-standing-data-service.arn}"
  target_id        = "${aws_instance.cyber.id}"
  port             = 8045

}
#  resource "aws_alb_listener" "benefit-content-service" {
#  load_balancer_arn = "${aws_alb.benefits-fer.arn}"
#  port              = 80
#  protocol          = "HTTP"

#  default_action {
#    target_group_arn = "${aws_alb_target_group.be-cyber.arn}"
#    type             = "forward"
#  }

resource "aws_alb_listener_rule" "benifits-standing-data-service" {
  listener_arn = "${aws_alb_listener.benifit-feature-members_listener.arn}"
  priority     = 35

  action {
    type             = "forward"
    target_group_arn = "${aws_alb_target_group.benifits-standing-data-service.arn}"
  }

  condition {
    field  = "path-pattern"
    values = ["/core/benefits/*"]
  }
}
resource "aws_alb_target_group" "api-communication-service" {
        name    = "api-communication-service"
        vpc_id = "${aws_vpc.gce_vpc.id}"
        port    = "80"
        protocol        = "HTTP"
        health_check {
                path = "/"
                port = "traffic-port"
                protocol = "HTTP"
                healthy_threshold = 2
                unhealthy_threshold = 2
                interval = 10
                timeout = 5
                matcher = "200,404"
        }
}

  resource "aws_alb_target_group_attachment" "api-communication-service-tg-attach" {
  target_group_arn = "${aws_alb_target_group.api-communication-service.arn}"
  target_id        = "${aws_instance.cyber.id}"
  port             = 8046

}
#  resource "aws_alb_listener" "api-communication-service" {
#  load_balancer_arn = "${aws_alb.benefits-feature-members-cyber.arn}"
#  port              = 80
#  protocol          = "HTTP"

#  default_action {
#    target_group_arn = "${aws_alb_target_group.benefits-feature-members-cyber.arn}"
#    type             = "forward"
#  }

resource "aws_alb_listener_rule" "api-communication-service" {
  listener_arn = "${aws_alb_listener.benifit-feature-members_listener.arn}"
  priority     = 36

  action {
    type             = "forward"
    target_group_arn = "${aws_alb_target_group.api-communication-service.arn}"
  }

  condition {
    field  = "path-pattern"
    values = ["/api/communication/*"]
  }
}

 resource "aws_elb" "swagger" {
  name = "swagger-qa-elb1"
  security_groups =      ["${aws_security_group.kong-elb-sec-group.id}"]
  subnets         =      ["${aws_subnet.subnet-1.id}","${aws_subnet.subnet-2.id}"]
  cross_zone_load_balancing   = true
  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 3
    interval = 30
    target = "TCP:8080"
  }
  listener {
    lb_port = 443
    lb_protocol = "HTTPS"
    instance_port = "8080"
    instance_protocol = "HTTP"
    ssl_certificate_id ="${aws_acm_certificate.cert.arn}"

  }
  instances                   = ["${aws_instance.netflix.id}"]
  cross_zone_load_balancing   = true
  idle_timeout                = 60
    tags = {
    Name = "swagger-qa-elb1"
  }
}

 resource "aws_elb" "netflix" {
  name = "netflix-qa-elb1"
  security_groups =      ["${aws_security_group.kong-elb-sec-group.id}"]
  subnets         =      ["${aws_subnet.subnet-1.id}","${aws_subnet.subnet-2.id}"]
  cross_zone_load_balancing   = true
  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 3
    interval = 30
    target = "TCP:5000"
  }
  listener {
    lb_port = 443
    lb_protocol = "HTTPS"
    instance_port = "5000"
    instance_protocol = "HTTP"
    ssl_certificate_id ="${aws_acm_certificate.cert.arn}"

  }
  instances                   = ["${aws_instance.netflix01.id}"]
  cross_zone_load_balancing   = true
  idle_timeout                = 60
    tags = {
    Name = "netflix-qa-elb1"
  }
}

resource "aws_elb" "h2ng-engage-qa-ui-elb" {
  name = "h2ng-engage-qa-ui-elb"
  security_groups =      ["${aws_security_group.kong-elb-sec-group.id}"]
  subnets         =      ["${aws_subnet.subnet-1.id}","${aws_subnet.subnet-2.id}"]
  internal        = true
  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 3
    interval = 30
    target = "HTTP:80/index.html"
  }
  listener {
    lb_port = 443
    lb_protocol = "HTTPS"
    instance_port = "80"
    instance_protocol = "HTTP"
    ssl_certificate_id ="${aws_acm_certificate.cert.arn}"

  }
  listener {
    lb_port = 80
    lb_protocol = "HTTP"
    instance_port = "80"
    instance_protocol = "HTTP"
}

  instances                   = ["${aws_instance.h2ng-2-ui.id}"]
  cross_zone_load_balancing   = true
  idle_timeout                = 60
    tags = {
    Name = "h2ng-engage-qa-ui-elb"
  }
}

resource "aws_alb_target_group" "benefits-sr-activities-orchest" {
        name    = "benefits-sr-activities-orchest"
        vpc_id = "${aws_vpc.gce_vpc.id}"
        port    = "80"
        protocol        = "HTTP"
        health_check {
                path = "/"
                port = "traffic-port"
                protocol = "HTTP"
                healthy_threshold = 2
                unhealthy_threshold = 2
                interval = 10
                timeout = 5
                matcher = "200,404"
        }
}

  resource "aws_alb_target_group_attachment" "benefits-sr-activities-orchest-tg-attach" {
  target_group_arn = "${aws_alb_target_group.benefits-sr-activities-orchest.arn}"
  target_id        = "${aws_instance.cyber.id}"
  port             = 8033

}
#  resource "aws_alb_listener" "benefit-content-service" {
#  load_balancer_arn = "${aws_alb.benefits-fer.arn}"
#  port              = 80
#  protocol          = "HTTP"

#  default_action {
#    target_group_arn = "${aws_alb_target_group.be-cyber.arn}"
#    type             = "forward"
#  }

resource "aws_alb_listener_rule" "benefits-sr-activities-orchest" {
  listener_arn = "${aws_alb_listener.benifit-feature-members_listener.arn}"
  priority     = 37

  action {
    type             = "forward"
    target_group_arn = "${aws_alb_target_group.benefits-sr-activities-orchest.arn}"
  }

  condition {
    field  = "path-pattern"
    values = ["/sr-activity-orchestration/*"]
  }
}

