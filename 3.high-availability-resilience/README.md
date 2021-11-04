## Route 53 routing

This lab will demonstrate how you can implement latency based routing in AWS.

We will generate two EIPs (Elastic IP's) in AWS (for durability), one in us-east-1 and one in us-west-2. 

Then, we will generate a zone in AWS linked to our newly created VPC, with one A record pointing in us-east-1 and one record pointing in us-west-2.

Again, this lab is intented for you to get a feeling on both the console, and Terraform.


## Tasks

1. Deploy the terraform resources:

```
terraform plan -out tfplan
```

```
terraform apply tfplan
```

2. Go to the console and launch an EC2 instance in us-east-1

3. Go to the console and launch an EC2 instance in us-west-2

4. Perform nslookups to see that you'll get resolution to the closest endpoint (latency based)
    * from us-east-1 you'll resolve the eip in us-east-1
    * form us-west-2 you'll resolve the eip in uw-west-2


## Things to note

This is just one of the strategies that we can implement for high availability and resilience. This can of course be integrated with Disaster Recovery strategies, such as **Pilot light**.
