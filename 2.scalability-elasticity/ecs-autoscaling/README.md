## Goal

Get hands-on actions when working with auto-scaling groups. For this lab we're going to focus on ECS autoscaling.

ECS autoscaling is achieved because ECS publishes certain metrics to Cloudwatch, and we can then translate those into an
AutoScaling action. This actions will trigger more *tasks* to deal with high demand at peak times, and scale-in during periods
of low utilization.

## Objective

1. Deploy the sample application under ECS using the code provided here.

2. Launch the terraform code for the Autoscaling policy and role.

3. Load-test the application using *hey* 

By the end of the lab you should see the task start to scale out, and at the end of the process, you should see it scale-in.

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

