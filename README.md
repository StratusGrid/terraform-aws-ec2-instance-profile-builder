<!-- BEGIN_TF_DOCS -->
# terraform-aws-ec2-instance-profile-builder

GitHub: [StratusGrid/terraform-aws-ec2-instance-profile-builder](https://github.com/StratusGrid/terraform-aws-ec2-instance-profile-builder)

This module helps create an instance profile with or without a custom policy(ies). It can add cloudwatch agent rights to IAM as well as ssm, and is often used solely to make a default iam instance profile which gives the privileges needed for cloudwatch agent and ssm to work.

## Example Usage:
Create a default role with permissions for ssm and cloudwatch agent:
```hcl
module "ec2_default_instance_profile" {
  source  = "StratusGrid/ec2-instance-profile-builder/aws"
  version = "2.0.0"
  # source                = "github.com/StratusGrid/terraform-aws-ec2-instance-profile-builder"

  instance_profile_name = "${var.name_prefix}-default-ec2-instance-profile${local.full_suffix}"
  input_tags            = merge(local.common_tags, {})
}
```
---
Create a role with custom permissions in addition to ssm and cloudwatch agent permissions:
```hcl
module "ec2_default_instance_profile" {
  source  = "StratusGrid/ec2-instance-profile-builder/aws"
  version = "2.0.0
  # source                = "github.com/StratusGrid/terraform-aws-ec2-instance-profile-builder"

  instance_profile_name = "${var.name_prefix}-default-ec2-instance-profile${local.full_suffix}"
  custom_policy_jsons    = ["${data.aws_iam_policy_document.my_custom_instance_policy.json}"]
  input_tags            = merge(local.common_tags, {})
}
```
---

## Resources

| Name | Type |
|------|------|
| [aws_iam_instance_profile.ec2_instance_profile](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_iam_policy.cloudwatch_agent](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.custom](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.ssm](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.ec2_instance_profile](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.cloudwatch_agent](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.custom](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.ssm](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cloudwatch_agent_policy"></a> [cloudwatch\_agent\_policy](#input\_cloudwatch\_agent\_policy) | True/False to add cloudwatch agent policy permissions to the IAM Role for the Instance Profile | `string` | `true` | no |
| <a name="input_custom_policy_jsons"></a> [custom\_policy\_jsons](#input\_custom\_policy\_jsons) | List of JSON strings of custom policies to be attached to the ec2 instance profile iam role | `list(string)` | `[]` | no |
| <a name="input_input_tags"></a> [input\_tags](#input\_input\_tags) | Map of tags to apply to resources | `map(string)` | <pre>{<br>  "Developer": "StratusGrid",<br>  "Provisioner": "Terraform"<br>}</pre> | no |
| <a name="input_instance_profile_name"></a> [instance\_profile\_name](#input\_instance\_profile\_name) | Unique string name of instance profile to be created. Also prepends supporting resource names | `string` | n/a | yes |
| <a name="input_ssm_policy"></a> [ssm\_policy](#input\_ssm\_policy) | True/False to add ssm policy permissions to the IAM Role for the Instance Profile | `string` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_instance_profile_arn"></a> [instance\_profile\_arn](#output\_instance\_profile\_arn) | ARN of Instance Profile used to reference the created objects in IAM policies |
| <a name="output_instance_profile_id"></a> [instance\_profile\_id](#output\_instance\_profile\_id) | ID of Instance Profile used to reference the created objects in aws\_instance resources |

---

<span style="color:red">Note:</span> Manual changes to the README will be overwritten when the documentation is updated. To update the documentation, run `terraform-docs -c .config/.terraform-docs.yml .`
<!-- END_TF_DOCS -->