#!/bin/bash

##run instaces custom
aws ec2 run-instances \
    --image-id ami-0866a3c8686eaeeba \
    --instance-type t2.micro \
    --count 1 \
    --key-name server
aws ec2 create-key-pair --key-name MyKeyPair
#--subnet-id subnet-08fc749671b2d077c \
#--security-group-ids sg-0b0384b66d7d692f9 \
#--user-data file://my_script.txt

#start the instances:
aws ec2 start-instances --instance-ids i-1234567890abcdef0

##stop the instances:
aws ec2 stop-instances --instance-ids i-1234567890abcdef0
DDD
