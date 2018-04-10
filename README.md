# Requirements

You're an employee working for a company that is migrating its core infrastructure to AWS and you're the person in charge of designing and setting up the Cloud infrastructure. You will have a public subnet and a private subnet in one VPC, and 2 servers: HTML web server in public subnet and Jenkins server in private subnet respectively. 

On the public subnet, all instances are reachable from the outside. However, everything running on the private subnet has very restricted access:
- Inbound and outbound traffic to the web server located on the public subnet and office IP is allowed.
- Inbound traffic from Github IPs is allowed
- All other traffic is rejected

Right now the Github IP endpoints are hardcoded in the ACLs and/or security groups applied to the private subnet and its instances. Luckily for you, Github publishes the updated list of the IPs it uses at https://api.github.com/meta. You need to find a way to maintain those rules as Github IP endpoints may change over time.

# Challenges
Here are the challenges:

- Provide Infrastructure as Code (Ansible, puppet, chef, Cloudformation, Terraform, etc.) that would launch a VPC with the 2 subnets on a dummy AWS account, as well as the Jenkins and HTML web servers. 

    Make sure the above restrictions are applied to the private subnet.
- Implement a solution to detect changes in Github IP list and update those ACLs and/or Security groups with the up-to-date IPs. 

    This task should be automated in such a way that other members of your team could run it when needed. 
    
    A plus would be to keep traces of each execution (logs). 
    Ideally, you want to have as many layers of security as possible to prevent accidental changes that may compromise the security of one layer. 

    Your solution should preserve any other custom IP ranges that were added to Security groups and/or network ACLs. 

    Your codes can be run in any AWS account, and once it’s run successfully, the Jenkins and web endpoint should be ready for access.
- Once Jenkins endpoint is ready, create Jenkins auto deployment job that each time you push a commit (HTML changes) to a private Github repository, it will trigger this job to deploy such HTML file to the web server you created in public subnet.  

    You can just create a dummy html file on your testing private git repository.

Please provide us with the source code of your solution as well as documentation describing how to use your solution.
Walk us through the different steps of your solution design.

In case you cannot complete the challenge in time, tell us why and write a high-level summary of how you would do it.
In case you think something is impossible, write a justification on why.

# Bonus Questions 
- If auto update IPs task relies on an AWS IAM user or Role to be executed, could you list the additional permissions required by this IAM user or Role for the task to run successfully?
- How would have this task run periodically?
- If possible, how would you make this solution generic enough so that it (or part of it) could be re-used to perform audits over existing ACLs and/or Security groups?
- How would you automate for creating such Jenkins web deployment job, instead of creating it manually in Jenkins web UI?
