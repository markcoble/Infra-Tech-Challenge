#!/bin/bash
# script to pull addresses from GitHub
# 
 
curl  https://api.github.com/meta > ip.txt

#  Logic to parse JSON and filter desired IP addresses

#  Execute appropriate aws command to update PrivateSubnetSG inbound rules
aws ec2 ....