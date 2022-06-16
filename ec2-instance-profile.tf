resource "aws_iam_role" "ec2_instance_profile" {
  name               = "${var.instance_profile_name}-role"
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

  tags = var.input_tags
}

resource "aws_iam_role" "vss_instance_profile" {
  name               = "${var.instance_profile_name}-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "ec2:CreateTags",
      "Resource": [
          "arn:aws:ec2:*::snapshot/*",
          "arn:aws:ec2:*::image/*"
      ]
    },
    {
      "Effect": "Allow",
      "Action": [
          "ec2:DescribeInstances",
          "ec2:CreateSnapshot",
          "ec2:CreateImage",
          "ec2:DescribeImages"
      ],
      "Resource": "*"
    }
  ]
}
EOF

  tags = local.tags
}

resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = "${var.instance_operating_system}-${var.instance_profile_name}"
  role = var.instance_operating_system == "Windows" ? aws_iam_role.vss_instance_profile.name : aws_iam_role.ec2_instance_profile.name
}
