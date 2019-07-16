resource "aws_iam_group" "h2ng_group" {
  name = "${var.h2ng_grp_name}"
  path = "${var.path}"
}

resource "aws_iam_group_policy_attachment" "group_policy_attachment" {
  count      = "${length(compact(distinct(var.policy_arns)))}"
  group      = "${aws_iam_group.h2ng_group.name}"
  policy_arn = "${element(var.policy_arns, count.index)}"
}

resource "aws_iam_group_membership" "h2ng_group" {
  name  = "${aws_iam_group.h2ng_group.name}"
  users = ["${compact(distinct(var.h2ng_qa_user))}"]
  group = "${aws_iam_group.h2ng_group.name}"
}