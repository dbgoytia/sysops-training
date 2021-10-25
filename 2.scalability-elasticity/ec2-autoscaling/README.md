## Goal

Get hands-on actions when working with auto-scaling groups. For this lab we're going to focus on EC2 autoscaling.

EC2 autoscaling is achieved because EC2 publishes certain metrics to Cloudwatch, inside the issue-remediation section, we will then translate those events into an AutoScaling action. This actions will trigger more instances to deal with high demand at peak times, and scale-in during periods of low utilization. For now, we will see how we can create a launch template, and an autoscaling group.

## Objective

1. Deploy the terraform code in here

2. See how does the autoscaling group events look like in the EC2 console.


## End result

In the end, you should see events of the autoscaling group activity tab to show something similar to this


Instance provisioning event:
```
PreInService: Launching a new EC2 instance: i-xxxxx -> At 2021-10-25T19:52:43Z a user request created an AutoScalingGroup changing the desired capacity from 0 to 1
```

Instance exists in ASG:
```
Successful: Launching a new EC2 instance: i-xxxxx -> At 2021-10-25T19:52:43Z a user request created an AutoScalingGroup changing the desired capacity from 0 to 1
```


## Core concepts

- Scalability → The ability of a system to increase resources to accommodate increased demand. This can be done vertically or horizontally (not necessarily automated)

- Elasticity → The ability of a system to increase and decrease resources allocated (usually horizontally)

- In general, an **elastic** resource is also **scalable,** but not always the other way around.

## Supported resources

- ec2 auto-scaling groups
- spot fleets
- DynamoDB scaling
- Aurora read replicas scaling
- ECS scaling

