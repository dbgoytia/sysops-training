## Route 53 routing

This lab will demonstrate how you can implement latency based routing in AWS. Goal is to understand the key role that DNS resolution plays in maintaining high available, highly scalable architectures in AWS.

We will generate two EIPs (Elastic IP's) in AWS (for durability), one in us-east-1 and one in us-west-2. 

Then, we will generate a zone in AWS linked to our newly created VPCs, with one A record pointing in us-east-1 vpc and one record pointing in us-west-2 vpc.

## Lab layout

![lab layout](https://github.com/dbgoytia/sysops-training/blob/main/3.high-availability-resilience/lab3.jpg?raw=true)

## Resources covered
* Route53 latency based routing
* EC2
* SSM
* A bit of basic Linux network troubleshooting

---

## Tasks

1. Deploy the terraform resources:

```
terraform plan -out tfplan
```

```
terraform apply tfplan
```


3. Perform nslookups to see that you'll get resolution to the closest endpoint (latency based)
    * from us-east-1 you'll resolve the eip in us-east-1
    * form us-west-2 you'll resolve the eip in uw-west-2


Example

*us-west-2*
```
# You'll always get the closest endpoint
Non-authoritative answer:
Name:   test.examplelatencyr.com
Address: 100.21.173.159
```

*us-east-1*
```
# You'll always get the closest endpoint
Non-authoritative answer:
Name:   test.examplelatencyr.com
Address: 44.199.148.62
```

--- 

## Next steps 

Understand business continuity plans (Disaster recovery), and the major role that something like IAC, Routing, Datastores and DNS resolution play in maintaining a buisness running after something goes wrong.


---- 

**ENJOY!**
