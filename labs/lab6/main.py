from typing import Callable
import boto3
from botocore.exceptions import ClientError
#from nice import print_title

def list_s3_buckets():
    """Lists all S3 buckets."""
    s3_client = boto3.client("s3")
    try:
        response = s3_client.list_buckets()
        print("\nS3 Buckets:")
        for bucket in response["Buckets"]:
            print(f"- {bucket['Name']}")
    except ClientError as e:
        print(f"Error: {e.response['Error']['Message']}")

def create_s3_bucket():
    """Creates an S3 bucket."""
    s3_client = boto3.client("s3")
    bucket_name = input("Enter the name for the new bucket: ")
    try:
        s3_client.create_bucket(Bucket=bucket_name)
        print(f"Bucket '{bucket_name}' created successfully!")
    except ClientError as e:
        print(f"Error: {e.response['Error']['Message']}")

def delete_s3_bucket():
    """Deletes an S3 bucket."""
    s3_client = boto3.client("s3")
    bucket_name = input("Enter the name of the bucket to delete: ")
    try:
        s3_client.delete_bucket(Bucket=bucket_name)
        print(f"Bucket '{bucket_name}' deleted successfully!")
    except ClientError as e:
        print(f"Error: {e.response['Error']['Message']}")

def list_ec2_instances():
    """Lists all running EC2 instances."""
    ec2_client = boto3.client("ec2")
    try:
        response = ec2_client.describe_instances()
        for reservation in response["Reservations"]:
            for instance in reservation["Instances"]:
                print(f"Instance ID: {instance['InstanceId']} - State: {instance['State']['Name']}")
    except ClientError as e:
        print(f"Error: {e.response['Error']['Message']}")

def start_ec2_instance():
    """Starts an EC2 instance."""
    ec2_client = boto3.client("ec2")
    instance_id = input("Enter the Instance ID to start: ")
    try:
        ec2_client.start_instances(InstanceIds=[instance_id])
        print(f"Starting EC2 instance {instance_id}")
    except ClientError as e:
        print(f"Error: {e.response['Error']['Message']}")

def stop_ec2_instance():
    """Stops an EC2 instance."""
    ec2_client = boto3.client("ec2")
    instance_id = input("Enter the Instance ID to stop: ")
    try:
        ec2_client.stop_instances(InstanceIds=[instance_id])
        print(f"Stopping EC2 instance {instance_id}")
    except ClientError as e:
        print(f"Error: {e.response['Error']['Message']}")


###################### Menu Methods ############################
def user_choice(menu: str, actions: dict[str, Callable]):
    while True:
        user_input = input(menu)
        if user_input == "q":
            break
        try:
            actions[user_input]()
        except KeyError:
            print("Unknown action, try again")


def manage_s3():
    sub_menu = """
    S3 Management:
    1. List Buckets
    2. Create Bucket
    3. Delete Bucket
    q. Back to Main Menu
    Choose an option: """
    user_choice(
        sub_menu, 
        {
            "1": list_s3_buckets, 
            "2": create_s3_bucket, 
            "3": delete_s3_bucket
        }
    )


def manage_ec2():
    sub_menu = """
    EC2 Management:
    1. List Instances
    2. Start Instance
    3. Stop Intance
    q. Press q to exit
    Choose an option: """

    user_choice(
        sub_menu,
        {
            "1": list_ec2_instances,
            "2": start_ec2_instance,
            "3": stop_ec2_instance,
        },
    )


###################### Main ############################
if __name__ == "__main__":
    
    main_menu = """
    AWS Resource Manager
    1. Manage S3 Buckets
    2. Manage EC2 Instances
    3. Press q to exit
    Choose an option: """
    #print_title("BOTO!")
    user_choice(main_menu, {"1": manage_s3, "2": manage_ec2 })






