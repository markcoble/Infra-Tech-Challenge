#!/bin/bash -e

BRANCH="preprod"

# get the node.json. This node.json would include recipes that build a webserver in an instance in public subnet.
# I believe chef recipes can also be used to actually do everything using a clean EC2 instance.  So using recipes
# like these could configure vpc https://github.com/chef/chef-provisioning-aws.  However, to keep the deployment indepentant of
# IaaS provider the EC2 instance should have the VPC config so that cookbooks used could work wiht other providers.
/usr/bin/aws --region eu-west-1 s3 cp s3://aznitro/chef/$BRANCH/config/webserver.node.json /etc/chef/node.json

# get the Berksfile
/usr/bin/aws --region eu-west-1 s3 cp s3://aznitro/chef/$BRANCH/config/Berksfile /etc/chef/Berksfile

# build webserver in public subnet
cd /var/chef/chef-repo/ && git pull
cd /root && /usr/local/bin/chef-update.sh && /usr/bin/chef-client

#  Alternatively a script like this could be used to create instance in public subnet with correct security group.

knife ec2 server create --flavor t2.micro --image ami-fd6cbd8a  \
--security-group-ids sg-abcd1234 --tags Name=instance-name      \
--node-name instance-name --environment staging                 \
--region eu-west-1 --availability-zone eu-west-1a               \
--subnet subnet-2233ccdd --associate-eip 55.77.1.1              \
--server-connect-attribute public_ip_address                    \
--run-list 'role[webserver]' --ebs-size 24                      \
--ebs-volume-type gp2 -x ubuntu -S GP-Staging    
