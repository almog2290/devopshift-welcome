import boto3
from botocore.exceptions import ClientError , BotoCoreError

class DeploymentVerifier:
    def __init__(self):
        self.ec2_client = boto3.client('ec2')
        self.elbv2_client = boto3.client('elbv2')

    def verify_ec2_instance(self, instance_id):
        try:
            response = self.ec2_client.describe_instances(InstanceIds=[instance_id])
            instances = response['Reservations'][0]['Instances']
            if instances and instances[0]['State']['Name'] == 'running':
                return instances[0].get('PublicIpAddress', None)
            return None
        except ClientError as e:
            print(f"Error verifying EC2 instance: {e}")
            return None
        except BotoCoreError as e:
            print(f"Error verifying EC2 instance: {e}")
            return None

    def verify_alb(self, alb_dns_name):
        try:
            response = self.elbv2_client.describe_load_balancers()
            load_balancers = response['LoadBalancers']
            for lb in load_balancers:
                if lb['DNSName'] == alb_dns_name and lb['State']['Code'] == 'active':
                    return True
            return False
        except ClientError as e:
            print(f"Error verifying ALB: {e}")
            return False
        except BotoCoreError as e:
            print(f"Error verifying ALB: {e}")
            return False

    def verify_deployment(self, instance_id, alb_arn):
        ec2_exists = self.verify_ec2_instance(instance_id)
        alb_exists = self.verify_alb(alb_arn)
        return ec2_exists and alb_exists