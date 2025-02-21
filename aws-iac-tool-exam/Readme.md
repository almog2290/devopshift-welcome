
# AWS IaC Tool - Almog Madar

This project provides an Infrastructure as Code (IaC) tool to automate the deployment of AWS resources using Terraform. The tool allows you to deploy an EC2 instance and an Application Load Balancer (ALB) in a specified AWS region and availability zone.

## Prerequisites

- Python 3.7+
- Terraform
- AWS CLI configured with appropriate credentials
- Required Python packages (listed in `requirements.txt`)

## Setup

1. **Clone the repository:**

    ```sh
    git clone <repository-url>
    cd aws-iac-tool-exam
    ```

2. **Install the required Python packages:**

    ```sh
    pip install -r requirements.txt
    ```

3. **Ensure Terraform is installed:**

    Follow the instructions on the [Terraform website](https://www.terraform.io/downloads.html) to install Terraform.

4. **Configure AWS CLI:**

    ```sh
    aws configure
    ```

## Usage

1. **Run the main script:**

    ```sh
    python main.py
    ```

2. **Follow the prompts to provide the necessary information:**

    - AMI Type (Ubuntu Linux or Amazon Linux)
    - EC2 Instance Type (t3.small or t3.medium)
    - AWS Region and Availability Zone
    - ALB Name

3. **The tool will:**

    - Generate the Terraform configuration file from the Jinja2 template.
    - Initialize, plan, and apply the Terraform configuration.
    - Verify the deployment and save the verification results in `aws_validation.json`.

## Files

- `main.py`: Main script to run the tool.
- `terraform/wrapper_tf.py`: Wrapper class for Terraform commands.
- `terraform/template/ec2_alb_template.tf.j2`: Jinja2 template for Terraform configuration.
- `aws/deployment_verification.py`: Class to verify the deployment using AWS SDK (boto3).
- `requirements.txt`: List of required Python packages.
- `aws_validation.json`: JSON file to store the verification results.
