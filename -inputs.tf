### Commented out name_prefix and name_suffix since there can only be one config stream and you don't see the name anywhere
### When you have names and the name changes, it requires manual intervention.

variable "instance_profile_name" {
  description = "Unique string name of instance profile to be created. Also prepends supporting resource names"
  type = "string"
}


variable "input_tags" {
  description = "Map of tags to apply to resources"
  type = "map"
  default = {
    Developer   = "StratusGrid"
    Provisioner = "Terraform"
  }
}

variable "ssm_policy" {
  description = "True/False to add ssm policy permissions to the IAM Role for the Instance Profile"
  type = "string"
  default = true
}

variable "cloudwatch_agent_policy" {
  description = "True/False to add cloudwatch agent policy permissions to the IAM Role for the Instance Profile"
  type = "string"
  default = true
}

variable "add_custom_policy_json" {
  description = "True/False to add create a profile using a custom policy json (specified in another variable)"
  type = "string"
  default = false
}

variable "custom_policy_json" {
  description = "JSON string of custom policy to be given ec2 instance profile."
  type        = "string"
  default     = ""
}
