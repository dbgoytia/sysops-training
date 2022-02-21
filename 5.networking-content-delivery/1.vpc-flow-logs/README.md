# VPC Flow logs

This lab is a demonstration of how you can use VPC Flow logs to successfully troubleshoot networking issues on AWS. Sometimes, we tend to do this out of memory and pure logic (which is fine as well), but having a means to do it in big scale is a very important factor in securing our AWS environments. 

VPC flow logs are great for troubleshooting highly secured environments. They are great for centralizing your logs for Data Analytics.

## Resources covered

* VPC
* VPC Flow logs
* Apache ( just a bit :) )


## Objectives:

1. Launch the terraform code
2. Troubleshoot and solve the problem using the generated VPC flow logs :).


---

## Solution

1. Launch the terraform code, this will generate:
    * A VPC 
    * An EC2 instance with HTTPD installed in a public subnet
    * An S3 bucket to store the flowlogs
    * Configuration of the VPC flow logs to s3

2. Log in to the EC2 instance using ssm

```
aws ssm start-session \
  --target i-0311a95dde6060248 \
  --region us-east-1
```

3. Generate some traffic from the internet, are you able to curl to the instance?

```
# Generate traffic:
!/bin/bash
while true;
do curl ec2-35-175-196-96.compute-1.amazonaws.com; sleep 2;
done;

>> curl: (7) Failed to connect to ec2-35-175-196-96.compute-1.amazonaws.com port 80: Connection refused
```

4. Troubleshoot using the flowlogs

```
2 608994313921 eni-09cb27ba765ce62e7 <YOUR-IP-ADDRESS> 10.255.100.172 4810 443 6 8 512 1637285866 1637285924 REJECT OK
```

The message above shows that traffic is being rejected, from your IP, using source port 4810, to destination port 443. The last OK represents that the event was succesfully logged

5. Solve the problem!

6. Test again and see a successfull flow log like the following:
```
HTTP/1.1 403 Forbidden
Date: Fri, 19 Nov 2021 01:49:10 GMT
Server: Apache/2.4.51 ()
Upgrade: h2,h2c
Connection: Upgrade
Last-Modified: Fri, 08 Oct 2021 22:01:06 GMT
ETag: "e2e-5cdde8415ac80"
Accept-Ranges: bytes
Content-Length: 3630
Content-Type: text/html; charset=UTF-8
```

> If you're seeing this HTTP response and the Test Page, means you started hitting the endpoint, but there's something missing on the server side.

> Extra assignment: Why is it showing a 403?

```
2 608994313921 eni-09cb27ba765ce62e7 <YOUR-IP-ADDRESS> 10.255.100.172 4711 80 6 1 64 1637286166 1637286224 ACCEPT OK
```

---

## Next steps


* Solve the 403 on httpd

* What other means do you have to more succesfully parse S3 logs? 
>Hint: Think Big Data and logs!    

* Imagine that you are a network administrator, and you been tasked to address a recent security risk: a malicious IP is trying to access your VPC. How would you deal with the situation? How would you validate the reject on the flowlogs?
--> Hint: When would you use a SG and when would you use a NACL? 

*we will cover this in another section of networking and content delivery section :), stay tuned!*


---

## Cleanup

```
## Validate what you're about to destroy
terraform plan -out tfplan -destroy

## Apply destroy
terraform apply tfplan
```

> You may need to first empty the S3 bucket from the AWS console

Enjoy!