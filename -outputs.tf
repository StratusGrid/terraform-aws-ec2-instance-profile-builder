output "instance_profile_id" {
  description = "ID of Instance Profile used to reference the created objects in aws_instance resources"
  value       = aws_iam_instance_profile.ec2_instance_profile.id
}

output "instance_profile_arn" {
  description = "ARN of Instance Profile used to reference the created objects in IAM policies"
  value       = aws_iam_instance_profile.ec2_instance_profile.arn
}

