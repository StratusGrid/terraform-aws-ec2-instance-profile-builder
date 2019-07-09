#ec2-instance-profile
ec2-instance-profile helps create an instance profile with or without a custom policy(ies). It can add cloudwatch agent rights to IAM as well as ssm, and is often used solely to make a default iam instance profile which gives the privileges needed for cloudwatch agent and ssm to work.

### Example Usage:
Create a default role with permissions for ssm and cloudwatch agent:
```
module "ec2_default_instance_profile" {
  source                = "StratusGrid/ec2-instance-profile/aws"
  version               = "1.0.0"
  # source                = "github.com/StratusGrid/terraform-aws-ec2-instance-profile"
  instance_profile_name = "${var.name_prefix}-default-ec2-instance-profile${local.name_suffix}"
  input_tags            = "${merge(local.common_tags,
    map(
    )
  )}"
}
```