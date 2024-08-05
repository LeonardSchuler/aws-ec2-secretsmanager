# Outputs mostly for convenience
# Fix quote formatting with:
# terraform output -raw ssm_ssh_port_forwarding_session_command

output "ssm_ssh_session_command" {
  description = "Command to start SSH like session (using SSM)"
  value       = "aws ssm start-session --target ${module.ec2.instance_id} --region ${local.region}"
}

output "ssm_ssh_port_forwarding_session_command" {
  description = "Command to port forward from EC2 to local"
  value       = "aws ssm start-session --target ${module.ec2.instance_id} --region ${local.region} --document-name AWS-StartPortForwardingSession --parameters '{\"localPortNumber\":[\"8080\"],\"portNumber\":[\"8000\"]}'"
}

output "secret_write" {
  description = "Write out a string to secret manager inside the EC2 using this CLI command."
  value       = "aws secretsmanager put-secret-value --secret-id ${module.secrets.secret_arn} --secret-string yoursecret"
}

output "secret_read" {
  description = "Read the secret inside the EC2 using this CLI command."
  value       = "aws secretsmanager get-secret-value --secret-id ${module.secrets.secret_arn}"
}
