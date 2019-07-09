resource "aws_iam_policy" "custom" {
  count  = "${var.add_custom_policy_json}"
  name   = "${var.instance_profile_name}-custom-policy"
  path   = "/"
  policy = "${var.custom_policy_json}"
}

resource "aws_iam_role_policy_attachment" "custom" {
  count      = "${var.add_custom_policy_json}"
  role       = "${aws_iam_role.ec2_instance_profile.name}"
  policy_arn = "${aws_iam_policy.custom.arn}"
}
