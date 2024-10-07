#!/bin/bash

#aws s3
#aws ec2
#aws vpc
#aws lambda
#aws volumes

##This is for aws s3
echo "#####################################################"
##make bucket aws s3 mb s3://ihihfhoFHh
##aws s3 mb s3://mybucket --region us-west-1
##aws s3 cp test.txt s3://mybucket/test2.txt
aws s3 ls | awk '{print $3}'
echo "#####################################################"

##aws ec2 instances
echo "################aws ec2 instances ##################"
aws ec2 describe-instances \
    --query "Reservations[*].Instances[*].[InstanceId]" \
    --output table

aws ec2 describe-instances \
    --filters Name=tag-key,Values=Name \
    --query 'Reservations[*].Instances[*].{Instance:InstanceId,AZ:Placement.AvailabilityZone,Name:Tags[?Key==`Name`]|[0].Value}' \
    --output table
# aws ec2 describe-instances \
#     --filters Name=tag-key,Values=Name \
#     --query 'Reservations[*].Instances[*].{Instance:InstanceId,AZ:Placement.AvailabilityZone,Name:Tags[?Key==`Name`]|[0].Value}' \
#     --output table
# aws ec2 run-instances \
#     --image-id ami-0866a3c8686eaeeba \
#     --instance-type t2.micro \
#     --key-name server \
#     --count 5
# aws ec2 describe-instances \
#     --filters Name=tag-key,Values=Name |
#     jq -r '.Reservations[].Instances[] | {Instance: .InstanceId, AZ: .Placement.AvailabilityZone, Name: (.Tags[] | select(.Key == "Name") | .Value)}'
#     --output table
#aws ec2 describe-instances | --query ".[*].[VolumeId, Size, State, AvailabilityZone]"

echo "##########################################################"
echo "####################aws vpc##############################"

aws ec2 describe-vpcs | --query

echo "########################################################"

echo "####################aws lambda#########################"
aws lambda list-functions | jq -r ".Functions[].FunctionName"
echo "######################################################"

echo "#############ec2 volumes"
aws ec2 describe-volumes \
    --query "Volumes[*].[VolumeId, Size, State, AvailabilityZone]" \
    --output table
echo "################################"
