resource "aws_iam_role" "lambda-kong-h2ng-role" {
    name    =   "lambda-kong-h2ng-role"
    assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}
#resource "aws_iam_policy_attachment" "kong-h2ng-lambda-policy-attach" {
#    name    =   "kong-h2ng-lambda-policy-attach"
#    users      = ["${aws_iam_user.kong_h2ng_user.name}"]
#    //roles       = "${aws_iam_role.lambda-kong-h2ng-role.name}"
#    policy_arn = "${aws_iam_policy.kong-h2ng-lambda-policy.arn}"
#}


resource "aws_iam_role_policy_attachment" "lambda-kong-h2ng-policy-attach" {
    role       = "${aws_iam_role.lambda-kong-h2ng-role.name}"
    policy_arn = "${aws_iam_policy.kongbucket-h2ng-s3-policy.arn}"
}

resource "aws_iam_role_policy_attachment" "lambda-kong-h2ng-policy1-attach" { 
    role       = "${aws_iam_role.lambda-kong-h2ng-role.name}"
    policy_arn = "arn:aws:iam::aws:policy/IAMReadOnlyAccess"
}

resource "aws_iam_role_policy_attachment" "iam_self_managed_attach" {
    role       = "${aws_iam_role.lambda-kong-h2ng-role.name}"
    policy_arn = "arn:aws:iam::aws:policy/IAMSelfManageServiceSpecificCredentials"
}

resource "aws_iam_role_policy_attachment" "fullaccess_lambda_attach" {
    role       = "${aws_iam_role.lambda-kong-h2ng-role.name}"
    policy_arn = "arn:aws:iam::aws:policy/AWSLambdaFullAccess"

}
/*
resource "aws_iam_role_policy_attachment" "admin_full_access_role_attach" {
    role       = "${aws_iam_role.lambda-kong-h2ng-role.name}"
    policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"

}*/

resource "aws_iam_role_policy_attachment" "kong-h2ng-lambda-policy-attach" {
    role       = "${aws_iam_role.lambda-kong-h2ng-role.name}"
    policy_arn = "${aws_iam_policy.kong-h2ng-lambda-policy.arn}"
}
resource "aws_iam_role_policy_attachment" "rbs-mobile-app-lambda-policy-attach" {
    role       = "${aws_iam_role.lambda-kong-h2ng-role.name}"
    policy_arn = "${aws_iam_policy.rbs-mobile-app-lambda-policy.arn}"

}

resource "aws_iam_role_policy_attachment" "cloudwatch-logs-policy-attach" {
    role       = "${aws_iam_role.lambda-kong-h2ng-role.name}"
    policy_arn = "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"

}

resource "aws_iam_role_policy_attachment" "iam-fullaccess-policy-attach" {
    role       = "${aws_iam_role.lambda-kong-h2ng-role.name}"
    policy_arn = "arn:aws:iam::aws:policy/IAMFullAccess"
}


resource "aws_iam_role" "ec2-cloudwatchlogs-role" {
  name = "ec2-cloudwatchlogs-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

  tags = {
      tag-key = "ec2-cloudwatchlogs-role"
  }
}

resource "aws_iam_instance_profile" "ec2-cloudwatchlogs-profile" {
  name = "ec2-cloudwatchlogs_profile"
  role = "${aws_iam_role.ec2-cloudwatchlogs-role.name}"
}

