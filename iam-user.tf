/*resource "aws_iam_access_key" "lb" {
user = "${aws_iam_user.lb.name}"
# pgp_key = "keybase:lb"
}

resource "aws_iam_user" "lb" {
name = "loadbalancer_user"
path = "/system/"
}

resource "aws_iam_user_policy" "lb_ro" {
name = "test"
user = "${aws_iam_user.lb.name}"

policy = <<EOF
{
"Version": "2012-10-17",
"Statement": [
{
"Action": [
  "*"
],
"Effect": "Allow",
"Resource": "*"
}
]
}
EOF
}
*/
resource "aws_iam_user" "Batch_user" {
  name = "Batch_user"
}

resource "aws_iam_user" "kong_h2ng_user" {
  name = "kong-h2ng-user"
}
/*
resource "aws_iam_user_policy_attachment" "readonly_access_attach" {

    user       = "${aws_iam_user.kong_h2ng_user.name}"

    policy_arn = "arn:aws:iam::aws:policy/IAMReadOnlyAccess"

}*/

resource "aws_iam_user" "sathish_user" {
  name = "sbhaojan@affiniongroup.com"
}
resource "aws_iam_user" "nandan_user" {
  name = "nkavalur@affiniongroup.com"
}
resource "aws_iam_user" "vikash_user" {
  name = "vbhandari@affiniongroup.com"
}
resource "aws_iam_user_policy_attachment" "iam_self_managed_attach" {
    user       = "${aws_iam_user.kong_h2ng_user.name}"
    policy_arn = "arn:aws:iam::aws:policy/IAMSelfManageServiceSpecificCredentials"
}

resource "aws_iam_user_policy_attachment" "cloudwatch_attach" {
    user       = "${aws_iam_user.vikash_user.name}"
    policy_arn = "arn:aws:iam::aws:policy/CloudWatchReadOnlyAccess"
}


resource "aws_iam_user_policy_attachment" "fullaccess_lambda_attach" {
    user       = "${aws_iam_user.kong_h2ng_user.name}"
    policy_arn = "arn:aws:iam::aws:policy/AWSLambdaFullAccess"
}



resource "aws_iam_policy" "kong-h2ng-lambda-policy" {
  name        = "kong-h2ng-lambda-policy"
  path        = "/"
  description = "Kong h2ng lambda policy"

  policy = <<EOF
{
      "Version": "2012-10-17",
      "Statement": [
          {
              "Sid": "VisualEditor0",
              "Effect": "Allow",
              "Action": [
                  "lambda:CreateFunction",
                  "lambda:UpdateEventSourceMapping",
                  "tag:GetResources",
                  "lambda:InvokeFunction",
                  "cloudwatch:GetMetricData",
                  "lambda:ListVersionsByFunction",
                  "lambda:GetFunction",
                  "lambda:ListAliases",
                  "lambda:UpdateFunctionConfiguration",
                  "iam:ListRoles",
                  "iam:PassRole",
                  "lambda:GetAccountSettings",
                  "lambda:GetFunctionConfiguration",
                  "cloudwatch:GetMetricStatistics",
                  "lambda:UpdateAlias",
                  "lambda:UpdateFunctionCode",
                  "lambda:ListTags",
                  "kms:ListAliases",
                  "lambda:ListEventSourceMappings",
                  "iam:ListRolePolicies",
                  "lambda:GetPolicy",
                  "lambda:AddPermission",
                  "lambda:RemovePermission"
              ],
              "Resource": "*"
          },
          {
              "Sid": "VisualEditor1",
              "Effect": "Allow",
              "Action": [
                  "iam:PassRole",
                  "logs:CreateLogStream",
                  "logs:DescribeLogGroups",
                  "logs:DescribeLogStreams",
                  "logs:GetLogEvents",
                  "logs:DescribeMetricFilters",
                  "logs:PutLogEvents"
              ],
              "Resource": [
                  "arn:aws:iam::234218843518:role/*",
                  "arn:aws:logs:eu-west-1:234218843518:log-group:/aws/lambda/*"

              ]
          },
          {
              "Sid": "VisualEditor2",
              "Effect": "Allow",
              "Action": "logs:CreateLogGroup",
              "Resource": "arn:aws:logs:eu-west-1:234218843518:log-group:/aws/lambda/*"
          }
      ]
  }
EOF
}

resource "aws_iam_user_policy_attachment" "helix-audit-data-policy-attach" {
    user       = "${aws_iam_user.Batch_user.name}"
    policy_arn = "${aws_iam_policy.helix-audit-data-policy.arn}"
}
/*resource "aws_iam_user_policy_attachment" "helix-audit-data-policy-attach1" {
    user       = "${aws_iam_user.sathish_user.name}"
    policy_arn = "${aws_iam_policy.helix-audit-data-policy.arn}"
}*/


resource "aws_iam_user_policy_attachment" "kong-h2ng-lambda-policy-attach" {
    user       = "${aws_iam_user.kong_h2ng_user.name}"
    policy_arn = "${aws_iam_policy.kong-h2ng-lambda-policy.arn}"
}


resource "aws_iam_user_policy_attachment" "iam_readonly_access_attach" {
    user       = "${aws_iam_user.kong_h2ng_user.name}"
    policy_arn = "arn:aws:iam::aws:policy/IAMReadOnlyAccess"
}

/*
resource "aws_iam_user_policy_attachment" "iam_full_access_attach" {
    user       = "${aws_iam_user.kong_h2ng_user.name}"
    policy_arn = "arn:aws:iam::aws:policy/IAMFullAccess"
}

resource "aws_iam_user_policy_attachment" "admin_full_access_attach" {
    user       = "${aws_iam_user.kong_h2ng_user.name}"
    policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}*/

resource "aws_iam_policy" "kongbucket-h2ng-s3-policy" {
  name        = "kongbucket-h2ng-s3-policy"
  path        = "/"
  description = "Kong bucket h2ng s3 policy"

  policy = <<EOF
{
      "Version": "2012-10-17",
      "Statement": [
          {
              "Sid": "VisualEditor0",
              "Effect": "Allow",
              "Action": [
                  "s3:PutAccountPublicAccessBlock",
                  "s3:GetAccountPublicAccessBlock",
                  "s3:ListAllMyBuckets",
                  "s3:HeadBucket"
              ],
              "Resource": "*"
          },
          {
              "Sid": "VisualEditor1",
              "Effect": "Allow",
              "Action": "s3:*",
              "Resource": [
                  "arn:aws:s3:::kongbucket-h2ng",
                  "arn:aws:s3:::kongbucket-functions-h2ng",
                  "arn:aws:s3:::comm-bucket-h2ng",
                  "arn:aws:s3:::communicationtemplate",
                  "arn:aws:s3:::communicationprocessedtemplate",
                  "arn:aws:s3:::kongbucket-functions-h2ng/*",
                  "arn:aws:s3:::kongbucket-h2ng/*",
                  "arn:aws:s3:::comm-bucket-h2ng/*",
                  "arn:aws:s3:::communicationprocessedtemplate/*",
                  "arn:aws:s3:::communicationtemplate/*"
              ]
          }
      ]
  }
EOF
}

resource "aws_iam_user_policy_attachment" "kongbucket-h2ng-s3-policy-attach" {
    user       = "${aws_iam_user.kong_h2ng_user.name}"
    policy_arn = "${aws_iam_policy.kongbucket-h2ng-s3-policy.arn}"
}

resource "aws_iam_policy" "rbs-mobile-app-lambda-policy" {
  name        = "rbs-mobile-app-lambda-policy"
  path        = "/"
  description = "RBS Mobile App Lambda policy"

  policy = <<EOF
{
      "Version": "2012-10-17",
      "Statement": [
          {
              "Sid": "VisualEditor0",
              "Effect": "Allow",
              "Action": [
                  "lambda:CreateFunction",
                  "lambda:UpdateEventSourceMapping",
                  "tag:GetResources",
                  "lambda:InvokeFunction",
                  "cloudwatch:GetMetricData",
                  "lambda:ListVersionsByFunction",
                  "lambda:GetFunction",
                  "lambda:ListAliases",
                  "lambda:UpdateFunctionConfiguration",
                  "iam:ListRoles",
                  "lambda:GetAccountSettings",
                  "lambda:GetFunctionConfiguration",
                  "cloudwatch:GetMetricStatistics",
                  "lambda:UpdateAlias",
                  "lambda:UpdateFunctionCode",
                  "lambda:ListTags",
                  "kms:ListAliases",
                  "lambda:ListEventSourceMappings",
                  "iam:ListRolePolicies",
                  "lambda:GetPolicy",
                  "lambda:AddPermission",
                  "lambda:RemovePermission"
              ],
              "Resource": "*"
          },
          {
              "Sid": "VisualEditor1",
              "Effect": "Allow",
              "Action": [
                  "iam:PassRole",
                  "logs:CreateLogStream",
                  "logs:DescribeLogGroups",
                  "logs:DescribeLogStreams",
                  "logs:GetLogEvents",
                  "logs:DescribeMetricFilters",
                  "logs:PutLogEvents"
              ],
              "Resource": [
                  "arn:aws:iam::006378141167:role/*",
                  "arn:aws:logs:eu-west-1:234218843518:log-group:/aws/lambda/*"
              ]
          },
          {
              "Sid": "VisualEditor2",
              "Effect": "Allow",
              "Action": "logs:CreateLogGroup",
              "Resource": "arn:aws:logs:eu-west-1:234218843518:log-group:/aws/lambda/*"
          }
      ]
  }
EOF
}

resource "aws_iam_policy" "helix-audit-data-policy" {
  name        = "helix-audit-data-policy"
  path        = "/"
  description = "Read write access to helix-audit-data-qa bucket"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "s3:PutAnalyticsConfiguration",
                "s3:GetObjectVersionTagging",
                "s3:CreateBucket",
                "s3:ReplicateObject",
                "s3:GetObjectAcl",
                "s3:DeleteBucketWebsite",
                "s3:PutLifecycleConfiguration",
                "s3:GetObjectVersionAcl",
                "s3:PutObjectTagging",
                "s3:DeleteObject",
                "s3:GetIpConfiguration",
                "s3:DeleteObjectTagging",
                "s3:GetBucketWebsite",
                "s3:PutReplicationConfiguration",
                "s3:DeleteObjectVersionTagging",
                "s3:GetBucketNotification",
                "s3:PutBucketCORS",
                "s3:GetReplicationConfiguration",
                "s3:ListMultipartUploadParts",
                "s3:PutObject",
                "s3:GetObject",
                "s3:PutBucketNotification",
                "s3:PutBucketLogging",
                "s3:GetAnalyticsConfiguration",
                "s3:GetObjectVersionForReplication",
                "s3:GetLifecycleConfiguration",
                "s3:ListBucketByTags",
                "s3:GetInventoryConfiguration",
                "s3:GetBucketTagging",
                "s3:PutAccelerateConfiguration",
                "s3:DeleteObjectVersion",
                "s3:GetBucketLogging",
                "s3:ListBucketVersions",
                "s3:ReplicateTags",
                "s3:RestoreObject",
                "s3:ListBucket",
                "s3:GetAccelerateConfiguration",
                "s3:GetBucketPolicy",
                "s3:PutEncryptionConfiguration",
                "s3:GetEncryptionConfiguration",
                "s3:GetObjectVersionTorrent",
                "s3:AbortMultipartUpload",
                "s3:PutBucketTagging",
                "s3:GetBucketRequestPayment",
                "s3:GetObjectTagging",
                "s3:GetMetricsConfiguration",
                "s3:DeleteBucket",
                "s3:PutBucketVersioning",
                "s3:ListBucketMultipartUploads",
                "s3:PutMetricsConfiguration",
                "s3:PutObjectVersionTagging",
                "s3:GetBucketVersioning",
                "s3:GetBucketAcl",
                "s3:PutInventoryConfiguration",
                "s3:PutIpConfiguration",
                "s3:GetObjectTorrent",
                "s3:PutBucketWebsite",
                "s3:PutBucketRequestPayment",
                "s3:GetBucketCORS",
                "s3:GetBucketLocation",
                "s3:ReplicateDelete",
                "s3:GetObjectVersion"
            ],
            "Resource": [
                "arn:aws:s3:::helix-audit-data-qa",
                "arn:aws:s3:::*/*"
            ]
        },
        {
            "Sid": "VisualEditor1",
            "Effect": "Allow",
            "Action": [
                "s3:ListAllMyBuckets",
                "s3:HeadBucket"
            ],
            "Resource": "*"
        }
    ]
}
EOF
}

resource "aws_iam_user_policy_attachment" "rbs-mobile-app-lambda-policy-attach" {
    user       = "${aws_iam_user.kong_h2ng_user.name}"
    policy_arn = "${aws_iam_policy.rbs-mobile-app-lambda-policy.arn}"
}

resource "aws_iam_policy_attachment" "helix-audit-data-policy1" {
  name       = "helix-audit-data-policy1"
  users      = ["${aws_iam_user.sathish_user.name}"]
  policy_arn = "arn:aws:iam::234218843518:policy/helix-audit-data-policy"
}
resource "aws_iam_policy_attachment" "helix-audit-data-policy3" {
  name       = "helix-audit-data-policy3"
  users      = ["${aws_iam_user.nandan_user.name}"]
  policy_arn = "arn:aws:iam::234218843518:policy/helix-audit-data-policy"
}

output "kong_h2ng_user_arn" {
  value = "${aws_iam_user.kong_h2ng_user.arn}"
}


# Access to codecommit for repo fingerprinting
resource "aws_iam_user" "code_commit_user" {
provider  = "aws.dev"
count = "${length(var.user_name)}"
name = "${element(var.user_name,count.index )}"

tags = {
    tag-key = "Code Commit User"
  }
}
resource "aws_iam_user_policy_attachment" "code_commit_policy_attach" {
  provider  = "aws.dev"
  count = "${length(var.user_name)}"
  user    = "${element(var.user_name,count.index )}"
  policy_arn = "${aws_iam_policy.fingerprinting_code_commit.arn}"
}

#output "secret" {
# value = "${aws_iam_access_key.lb.encrypted_secret}"


# Access to QA account to H2NG QA team
resource "aws_iam_user" "h2ng_qa_user" {
//provider  = "aws.dev"
count = "${length(var.h2ng_qa_user)}"
name = "${element(var.h2ng_qa_user,count.index )}"

tags = {
    tag-key = "H2NG QA team"
  }
}


resource "aws_iam_role_policy" "cloudwatch_logs" {
  name = "cloudwatch_logs"
  role = "${aws_iam_role.ec2-cloudwatchlogs-role.id}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents",
        "logs:DescribeLogGroups",
        "logs:DescribeLogStreams"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}



