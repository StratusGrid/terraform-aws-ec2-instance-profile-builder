resource "aws_iam_policy" "custom" {
  count  = length(var.custom_policy_jsons)
  name   = "${var.instance_profile_name}-custom-policy-${count.index}"
  path   = "/"
  policy = element(var.custom_policy_jsons[count.index])
}

resource "aws_iam_role_policy_attachment" "custom" {
  count      = length(var.custom_policy_jsons)
  role       = aws_iam_role.ec2_instance_profile.name
  policy_arn = element(aws_iam_policy.custom.[count.index].arn)
}

