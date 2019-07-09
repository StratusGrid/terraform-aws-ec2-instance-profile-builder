#This will create a role and instance profile for default use on EC2 instance
#This includes permissions for the following services
# - SSM
# - Cloudwatch Agent with Logging

#S3 buckets may need added, but it is usually only with VPC endpoint, not for things without internet access unless you need additional bucket access.

#Give ability to merge a policy that is fed in as variable.

# Add default S3 in? - https://docs.aws.amazon.com/systems-manager/latest/userguide/setup-create-vpc.html

#Break into separate flags for SSM, CloudWatch Agent, Domain Services, and others? - https://docs.aws.amazon.com/systems-manager/latest/userguide/setup-instance-profile.html

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
  tags = "${var.input_tags}"
}

resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = "${var.instance_profile_name}"
  role = "${aws_iam_role.role.name}"
}

