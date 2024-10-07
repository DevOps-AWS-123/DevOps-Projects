#!/bin/bash

# Describe EC2 instances
echo "EC2 Instances:"
aws ec2 describe-instances \
    --filters Name=tag-key,Values=Name \
    --query 'Reservations[*].Instances[*].{Instance:InstanceId,AZ:Placement.AvailabilityZone,Name:Tags[?Key==`Name`]|[0].Value}' \
    --output table

# List S3 buckets
echo "S3 Buckets:"
aws s3api list-buckets \
    --query "Buckets[*].Name" \
    --output table

# Describe EBS volumes
echo "EBS Volumes:"
aws ec2 describe-volumes \
    --query "Volumes[*].[VolumeId,State,Size,AvailabilityZone]" \
    --output table

# Describe VPCs
echo "VPCs:"
aws ec2 describe-vpcs \
    --query "Vpcs[*].[VpcId,State,CidrBlock]" \
    --output table

# List Lambda functions
echo "Lambda Functions:"
aws lambda list-functions \
    --query "Functions[*].[FunctionName,Runtime]" \
    --output table

# # Print completion message
# echo "Resource details have been saved to $output_file"
