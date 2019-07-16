resource "aws_customer_gateway" "vpn1" {
  bgp_asn = 65380
  ip_address = "${var.CSR1}"  // Trasit VPN device

  type = "ipsec.1"

  tags {
    Name = "CSR1"
    terraform = true
  }
}

resource "aws_customer_gateway" "vpn2" {
  bgp_asn = 65380
  ip_address = "${var.CSR2}"  // Trasit VPN device

  type = "ipsec.1"

  tags {
    Name = "CSR2"
    terraform = true
  }
}

resource "aws_vpn_gateway" "vpn" {

  vpc_id = "${aws_vpc.gce_vpc.id}"

  tags {
    Name = "DatahubQA-vpn-gateway"
    terraform = true
  }
}

resource "aws_vpn_connection" "vpn1" {
  vpn_gateway_id = "${aws_vpn_gateway.vpn.id}"
  customer_gateway_id = "${aws_customer_gateway.vpn1.id}"
  type = "ipsec.1"
  static_routes_only = false
  tunnel1_inside_cidr = "${var.tunnel1}"
  tunnel2_inside_cidr = "${var.tunnel2}"

  tags {
    Name = "CSR1_vpn_connection"
    terraform = true
    }
    }
    resource "aws_vpn_connection" "vpn2" {
      vpn_gateway_id = "${aws_vpn_gateway.vpn.id}"
      customer_gateway_id = "${aws_customer_gateway.vpn2.id}"
      type = "ipsec.1"
      static_routes_only = false

      tunnel1_inside_cidr = "${var.tunnel1-a}"
      tunnel2_inside_cidr = "${var.tunnel2-a}"

      tags {
        Name = "CSR2_vpn_connection"
        terraform = true
        }
        }
