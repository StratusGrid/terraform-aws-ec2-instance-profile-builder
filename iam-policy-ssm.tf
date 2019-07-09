data "aws_iam_policy_document" "ssm" {
  statement {
    sid = "ssm"

    actions = [
      "ssm:DescribeAssociation",
      "ssm:GetDeployablePatchSnapshotForInstance",
      "ssm:GetDocument",
      "ssm:DescribeDocument",
      "ssm:GetManifest",
      "ssm:GetParameter",
      "ssm:GetParameters",
      "ssm:ListAssociations",
      "ssm:ListInstanceAssociations",
      "ssm:PutInventory",
      "ssm:PutComplianceItems",
      "ssm:PutConfigurePackageResult",
      "ssm:UpdateAssociationStatus",
      "ssm:UpdateInstanceAssociationStatus",
      "ssm:UpdateInstanceInformation"
    ]

    resources = [
      "*",
    ]
  }
  statement {
    sid = "ssmmessages"

    actions = [
      "ssmmessages:CreateControlChannel",
      "ssmmessages:CreateDataChannel",
      "ssmmessages:OpenControlChannel",
      "ssmmessages:OpenDataChannel"
    ]

    resources = [
      "*",
    ]
  }
  statement {
    sid = "ec2messages"

    actions = [
      "ec2messages:AcknowledgeMessage",
      "ec2messages:DeleteMessage",
      "ec2messages:FailMessage",
      "ec2messages:GetEndpoint",
      "ec2messages:GetMessages",
      "ec2messages:SendReply"
    ]

    resources = [
      "*",
    ]
  }
  # You would be able to add this for a single region this way, but IAM resources are global.
  # This would only be needed with S3 VPC Endpoints, which are unlikely to be used. If needed, add a static list of regions to support, or merge in the custom policy.
  # Reference: https://docs.aws.amazon.com/systems-manager/latest/userguide/setup-create-vpc.html
  # statement {
  #   sid = "s3"

  #   actions = [
  #     "s3:*"
  #   ]

  #   resources = [
  #     "arn:aws:s3:::patch-baseline-snapshot-${data.aws_region.current.name}/*",
  #     "arn:aws:s3:::aws-ssm-${data.aws_region.current.name}/*"
  #   ]
  # }
}


resource "aws_iam_policy" "ssm" {
  count  = "${var.ssm_policy}"
  name   = "${var.instance_profile_name}-ssm-policy"
  path   = "/"
  policy = "${data.aws_iam_policy_document.ssm.json}"
}

resource "aws_iam_role_policy_attachment" "ssm" {
  count      = "${var.ssm_policy}"
  role       = "${aws_iam_role.ec2_instance_profile.name}"
  policy_arn = "${aws_iam_policy.ssm.arn}"
}
