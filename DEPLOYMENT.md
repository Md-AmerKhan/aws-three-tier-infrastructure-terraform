# Deployment Guide – AWS Three-Tier Infrastructure using Terraform

## 1. Project Overview

This project provisions a three-tier architecture on Amazon Web Services (AWS) using Terraform.

The infrastructure consists of:

- **Web Tier:** Private EC2 instance serving HTTP traffic.
- **Application Tier:** Two private EC2 instances running the application layer.
- **Database Tier:** Private EC2 instance running MariaDB.
- **Public Application Load Balancer:** Receives internet traffic and forwards requests to the web tier.
- **Private Application Load Balancer:** Routes internal application traffic to the application tier.

## 2. Prerequisites

Before deployment, ensure the following tools and access are available:

- AWS account with the required permissions.
- Terraform v1.5 or later.
- AWS CLI.
- Git.
- Visual Studio Code or another code editor.

Configure AWS credentials using:

```bash
aws configure
```

Verify the AWS identity:

```bash
aws sts get-caller-identity
```

The project uses the AWS Mumbai region (`ap-south-1`).

## 3. Clone the Repository

```bash
git clone https://github.com/Md-AmerKhan/aws-three-tier-infrastructure-terraform.git
```

Navigate into the project directory:

```bash
cd aws-three-tier-infrastructure-terraform
```

## 4. Configure Terraform Variables

Review the Terraform variable definitions and the example configuration.

Create your local variable file if required:

```bash
cp terraform.tfvars.example terraform.tfvars
```

Update the values according to your AWS environment.

**Security:** Do not commit real credentials, private keys, or sensitive variable files to GitHub.

## 5. Initialize Terraform

Download and initialize the required Terraform providers and modules:

```bash
terraform init
```

## 6. Format and Validate

Format the Terraform configuration:

```bash
terraform fmt -recursive
```

Validate the configuration:

```bash
terraform validate
```

## 7. Review the Execution Plan

Generate the infrastructure execution plan:

```bash
terraform plan
```

Review the proposed resources and changes before deployment.

## 8. Deploy the Infrastructure

Apply the Terraform configuration:

```bash
terraform apply
```

Review the plan and confirm the operation when prompted.

Terraform provisions the networking, security groups, EC2 instances and load balancers.

## 9. View Terraform Outputs

Display the deployment outputs:

```bash
terraform output
```

Important outputs include:

- VPC ID
- Public ALB DNS name
- Private ALB DNS name
- Application instance private IP addresses
- Database private IP address

## 10. Test the Deployment

### Test 1: Public Load Balancer

Copy the public ALB DNS name from Terraform outputs and open:

```text
http://<PUBLIC-ALB-DNS-NAME>
```

The web server should return an HTTP response.

### Test 2: Application Tier

Access the application route through the public web endpoint:

```text
http://<PUBLIC-ALB-DNS-NAME>/app/
```

The application tier is configured with two instances. Repeated requests can demonstrate the load-balancing behaviour between the application servers.

### Test 3: Private Network

The private ALB is internal-facing and is intended to receive traffic from within the VPC.

Its DNS name is available through Terraform outputs.

### Test 4: Database Connectivity

The database instance is deployed in a private subnet. Database access is restricted through security-group rules, allowing the application tier to communicate with MariaDB on port 3306.

## 11. Infrastructure Security

The project implements network-level security through AWS Security Groups.

- Public access is provided through the public ALB.
- Application instances are deployed in private subnets.
- Database access is restricted to the application security group.
- SSH access is restricted through the configured administrator CIDR.
- Private instances use NAT Gateways for outbound internet access.
- IAM instance roles are configured for Systems Manager access.

The database port 3306 is a narrowly scoped tier-to-tier exception required for MariaDB communication.

## 12. Terraform Cleanup

When the infrastructure is no longer required, remove the provisioned resources:

```bash
terraform destroy
```

Review the destruction plan carefully and confirm only when you intend to delete the infrastructure.

**Warning:** This operation removes Terraform-managed AWS resources. Do not execute it while the infrastructure is still required for demonstration or evaluation.

After cleanup, verify that no unintended AWS resources remain.

## 13. Project Repository

GitHub:

https://github.com/Md-AmerKhan/aws-three-tier-infrastructure-terraform

## 14. Author

**Md Amer Khan**

AWS | Terraform | Cloud Infrastructure | DevOps

