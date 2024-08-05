# AWS EC2 Secrets Manager Terraform Configuration

This repository contains Terraform code to provision an AWS EC2 instance with a VPC, associated IAM roles, security groups, and a secret managed by AWS Secrets Manager. The infrastructure is organized into reusable modules for better manageability and scalability. The environment details are separated away from the modules. The structure promotes composability and dependency inversion.
State is managed locally.

## Repository Structure

- `infrastructure/environments/dev/main.tf`: Main configuration for the development environment.
- `infrastructure/modules/vpc/main.tf`: VPC module configuration.
- `infrastructure/modules/ec2/main.tf`: EC2 instance module configuration.
- `infrastructure/modules/secrets/main.tf`: Secrets Manager module configuration.

## Usage

### Prerequisites

- Terraform installed on your local machine.
- AWS CLI configured with appropriate permissions.
- An AWS account with necessary permissions to create VPCs, EC2 instances, IAM roles, and Secrets Manager secrets.

### Steps

1. **Clone the repository**

   ```sh
   git clone https://github.com/your-username/aws-ec2-secretsmanager.git
   cd aws-ec2-secretsmanager
   ```
2. **Obtain and set AWS Credentials as environment variables**
   ```sh
    AWS_ACCESS_KEY_ID=
    AWS_SECRET_ACCESS_KEY=
    AWS_SESSION_TOKEN=
   ```
   You can validate the credentials using
   ```sh
   aws sts get-caller-identity
   ```
3. **Navigate to the environment configuration directory**
   ```sh
   cd infrastructure/environments/dev
   ```

4. **Initialize Terraform**
   ```sh
   terraform init
   ```


5. **Plan the deployment**
   ```sh
   terraform plan -out tfplan
   ```


6. **Apply the deployment**
   ```sh
   terraform apply tfplan
   ```

7. **(Optional) Destroy the deployment**
   ```sh
   terraform destroy
   ```

## Configuration Details
### Environment (`infrastructure/environments/dev/main.tf`)
This configuration sets up the development environment consuming the modules with the following components:
- VPC: Defined in vpc module, using the terraform-aws-modules/vpc/aws module.
- EC2 Instance: Defined in ec2 module, using the terraform-aws-modules/ec2-instance/aws module.
- Secrets Manager: Defined in secrets module, creating a secret to be used by the EC2 instance.
### VPC Module (`infrastructure/modules/vpc/main.tf`)
- Provisions a VPC with public and private subnets.
- Uses terraform-aws-modules/vpc/aws for VPC creation.
- Disables NAT gateway for simplicity and cost efficiency.
### EC2 Module (`infrastructure/modules/ec2/main.tf`)
- Provisions an EC2 instance with an associated IAM role and policies.
- Uses terraform-aws-modules/ec2-instance/aws for EC2 instance creation.
- Includes security group creation and IAM policy to access Secrets Manager.
- User data script included to ensure SSM agent restarts properly.
- Secrets Manager Module (infrastructure/modules/secrets/main.tf)
- Creates a secret in AWS Secrets Manager.
- Allows zero-day recovery window for simplicity but can be adjusted as needed.