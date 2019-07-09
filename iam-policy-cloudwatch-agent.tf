data "aws_iam_policy_document" "cloudwatch_agent" {
  statement {
    sid = "CloudWatchAgentServerPolicy"

    actions = [
      "cloudwatch:PutMetricData",
      "ec2:DescribeTags",
      "logs:PutLogEvents",
      "logs:DescribeLogStreams",
      "logs:DescribeLogGroups",
      "logs:CreateLogStream",
      "logs:CreateLogGroup"
    ]

    resources = [
      "*",
    ]
  }
  statement {
    sid = "CloudWatchAgentServerParametersPolicy"

    actions = [
      "ssm:GetParameter"
    ]

    resources = [
      "arn:aws:ssm:*:*:parameter/AmazonCloudWatch-*",
    ]
  }
}

resource "aws_iam_policy" "cloudwatch_agent" {
  count  = "${var.cloudwatch_agent_policy}"
  name   = "${var.instance_profile_name}-cloudwatch-agent-policy"
  path   = "/"
  policy = "${data.aws_iam_policy_document.cloudwatch_agent.json}"
}

resource "aws_iam_role_policy_attachment" "cloudwatch_agent" {
  count      = "${var.cloudwatch_agent_policy}"
  role       = "${aws_iam_role.ec2_instance_profile.name}"
  policy_arn = "${aws_iam_policy.cloudwatch_agent.arn}"
}
