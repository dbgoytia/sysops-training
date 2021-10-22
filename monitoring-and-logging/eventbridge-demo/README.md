## Goal

Goal of this demo is to provide an example on how to create an EventBridge event based
on EC2 Actions.

## Objective

1. Launch a VPC for hosting an EC2 instance.

2. Launch an EC2 Instance for testing (Amazon Linux)

3. Create an SNS Topic:
    * subscribe my personal email and confirm the subscription

4. Create a Rule on EventBridge:
    * should notify us into any EC2 state change using SNS

## Testing:

* Stop the instance and see if we haver received the email notification.


