Generated with `terraform-docs markdown . > README.md`
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | ~> 3.6 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_ec2"></a> [ec2](#module\_ec2) | ../../modules/ec2 | n/a |
| <a name="module_secrets"></a> [secrets](#module\_secrets) | ../../modules/secrets | n/a |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | ../../modules/vpc | n/a |

## Resources

No resources.

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_secret_read"></a> [secret\_read](#output\_secret\_read) | Read the secret inside the EC2 using this CLI command. |
| <a name="output_secret_write"></a> [secret\_write](#output\_secret\_write) | Write out a string to secret manager inside the EC2 using this CLI command. |
| <a name="output_ssm_ssh_port_forwarding_session_command"></a> [ssm\_ssh\_port\_forwarding\_session\_command](#output\_ssm\_ssh\_port\_forwarding\_session\_command) | Command to port forward from EC2 to local |
| <a name="output_ssm_ssh_session_command"></a> [ssm\_ssh\_session\_command](#output\_ssm\_ssh\_session\_command) | Command to start SSH like session (using SSM) |
