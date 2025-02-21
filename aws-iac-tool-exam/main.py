
import os
import jinja2
import json
from pydantic import BaseModel, ValidationError
from terraform.wrapper_tf import TerraformWrapper
from aws.deployment_verification import DeploymentVerifier
from typing import ClassVar


class AWSIaCTool(BaseModel):
    region: str
    availability_zone : str
    instance_type: str
    instance_name: str
    ami_id: str
    alb_name: str
    template_path: ClassVar[str] = os.path.join('terraform', 'template', 'ec2_alb_template.tf.j2')
    tf_config_path: ClassVar[str] = os.path.join('terraform', 'template', 'terraform.tf')
    terraform_wrapper: ClassVar[TerraformWrapper] = TerraformWrapper(terraform_dir='terraform/template')
    deployment_verifier: ClassVar[DeploymentVerifier] = DeploymentVerifier()
    # extra information
    instance_id: str | None = None
    lb_dns_name: str | None = None

    def generate_terraform_config(self):
        try:
            with open(self.template_path , "r") as template_file:
                template = jinja2.Template(template_file.read())

            config = template.render(
                region=self.region,
                ami=self.ami_id,
                instance_type=self.instance_type,
                availability_zone=self.availability_zone,
                load_balancer_name=self.alb_name,
                instance_name=self.instance_name
            )

            with open(self.tf_config_path, 'w') as config_file:
                config_file.write(config)

        except Exception as e:
            print(f"Error generating Terraform configuration: {e}")

    def deploy(self):
        try:
            self.terraform_wrapper.init()
            self.terraform_wrapper.plan()
            self.terraform_wrapper.apply()
            output = self.terraform_wrapper.get_output()
            self.instance_id = output['instance_id']['value']
            self.lb_dns_name = output['lb_dns_name']['value']

        except Exception as e:
            print(f"Error during Terraform deployment: {e}")

    def verify_deployment(self):
        try:
            public_ip = self.deployment_verifier.verify_ec2_instance(self.instance_id)
            verifier_alb = self.deployment_verifier.verify_alb(self.lb_dns_name)

            verification_data = {
                "instance_id": self.instance_id,
                "instance_state": "running" if public_ip else "not running",
                "public_ip": public_ip,
                "load_balancer_dns": self.lb_dns_name
            }

            with open('aws_validation.json', 'w') as json_file:
                json.dump(verification_data, json_file, indent=4)

            if public_ip and verifier_alb:
                print("Deployment verified successfully.")
            else:
                print("Deployment verification failed.")
        except Exception as e:
            print(f"Error verifying deployment: {e}")


def user_choice(initPrompt: str , selectionOptions: dict[str,str]) -> str:
    while True:
        user_selection = input(initPrompt)
        if user_selection == '1':
            return selectionOptions['1']

        elif user_selection == '2':
            return selectionOptions['2']
        else:
            print("Invalid selection. please try again")



def main():

    main_menu = """
    Welcome for AWS Automation Tool
    Please provide the following information to deploy the infrastructure:
    1. AMI Type : Ubuntu Linux or Amazon Linux.
    2. EC2 Instance Type :  t3.small or t3.medium.
    3. Region area and Availability Zone.
    4. ALB Name (Application Load Balancer).
    """

    az_list_menu = """
    Please choose the availability zone:
    1. us-east-1a - press [1]
    2. us-east-1b - press [2]
    3. us-east-1c - press [3]
    4. us-east-1d - press [4]
    5. us-east-1e - press [5]
    6. us-east-1f - press [6]
    """

    # 1. Ubuntu Linux , 2. Amazon Linux
    ami_options = {
        '1': 'ami-0c02fb55956c7d316',
        '2': 'ami-0ff8a91507f77f867'
    }

    ec2_instance_options = {
        '1': 't3.small',
        '2': 't3.medium'
    }

    az_list_options = {
        '1': 'us-east-1a',
        '2': 'us-east-1b',
        '3': 'us-east-1c',
        '4': 'us-east-1d',
        '5': 'us-east-1e',
        '6': 'us-east-1f'
    }

    print(main_menu)

    ami_id = user_choice(
        "AMI Type - Ubuntu Linux [1] or Amazon Linux [2]: ",
        ami_options
    )

    instance_type= user_choice(
        "EC2 Instance Type :  t3.small [1] or t3.medium [2]: ",
        ec2_instance_options
    )


    while True:
        region_selection = input("Please choose the aws region: ")
        if not region_selection == 'us-east-1':
            print("Invalid region. change to default region us-east-1")
            region_selection = 'us-east-1'

        print(az_list_menu)    
        az_ch = input("Please choose the availability zone: ")
        if az_ch not in az_list_options.keys():
            print("Invalid availability zone. Please try again")
            continue
        else:
            az_selection = az_list_options[az_ch]   
            break


    alb_name = input("Please enter the ALB name: ")
    
    aws_iac_tool = AWSIaCTool(
        region=region_selection, 
        availability_zone=az_selection,
        instance_type=instance_type, 
        ami_id=ami_id, 
        alb_name=alb_name,
        instance_name=alb_name
    )

    aws_iac_tool.generate_terraform_config()
    aws_iac_tool.deploy() 
    aws_iac_tool.verify_deployment()

if __name__ == "__main__":
    main()