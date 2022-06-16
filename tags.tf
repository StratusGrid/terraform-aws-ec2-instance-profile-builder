locals {
  tags = merge(var.input_tags, {
    "ModuleSourceRepo" = "github.com/StratusGrid/terraform-aws-ec2-instance-profile-builder"
  })
}