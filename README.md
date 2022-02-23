## Goal

A collection of labs designed for getting some hands-on experience with the
service required to pass the AWS Sysops certification.

## How to use this hands-on labs

Go to the appropiate directory location (cd into it), and and start the commands listed in each section.


## AWS Services you'll use along the training:


* ![Aurora](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/CHAP_AuroraOverview.html)
* ![Compute Optimizer](https://docs.aws.amazon.com/compute-optimizer/latest/ug/what-is-compute-optimizer.html)
* ![CloudFormation](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/Welcome.html)
* ![CloudFront](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/Introduction.html)
* ![CloudWatch](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/WhatIsCloudWatch.html)
* ![EBS](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/AmazonEBS.html)
* ![EC2](https://docs.aws.amazon.com/ec2/index.html)
* ![EC2 Image Builder](https://docs.aws.amazon.com/imagebuilder/latest/userguide/what-is-image-builder.html)
* ![EFS](https://docs.aws.amazon.com/efs/latest/ug/whatisefs.html)
* ![EventBridge](https://docs.aws.amazon.com/eventbridge/latest/userguide/eb-what-is.html)
* ![Guard Duty](https://docs.aws.amazon.com/guardduty/latest/ug/what-is-guardduty.html)
* ![KMS](https://docs.aws.amazon.com/kms/latest/developerguide/overview.html)
* ![OpenSearch](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/what-is.html)
* ![RDS](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Welcome.html)
* ![Route 53](https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/Welcome.html)
* ![S3](https://docs.aws.amazon.com/AmazonS3/latest/userguide/Welcome.html)
* ![Systems Manager](https://docs.aws.amazon.com/systems-manager/latest/userguide/what-is-systems-manager.html)
* ![VPC](https://docs.aws.amazon.com/vpc/latest/userguide/what-is-amazon-vpc.html)
* ![WAF](https://docs.aws.amazon.com/waf/latest/developerguide/waf-chapter.html)


## Quick note about the Terraform implementation

This is not, by any way or means, an implementation of a successfull deployment strategy
through Terraform. I'll try to keep everything modularized, but deployment will happen 
"as-a-whole" instead of the preferred approach which is to have sepparate subgroups for each
infra resource (for blast-radius reduction, readability, maintainability, etc).

Some other things you'll notice aren't there are the S3 buckets for the Terraform state.
I didn't bother adding this kind of configuration to the labs because they are very ephemeral,
but please be welcome to add this yourself on each one of the sections using the configuration listed
in the documentations online:

https://www.terraform.io/docs/language/settings/backends/s3.html

## Disclaimer

Beware that using some of this components might incur in some extra costs to your AWS resources. 
I'm doing this labs on my own and not at all related to my current employer, and is not meant to replace any formal
AWS Training, rather complement it.
