## Goal

Goal of this demo is to provide an example on how to create an EventBridge event based
on EC2 Actions. It is partially created in Terraform, so we can see some of the configurations
happening live on the AWS Console.

## Objective

1. Launch the terraform code in here.

2. Create a Rule on EventBridge:
    * Add an event pattern using the AWS Default Event Bus
    * Use AWS as the service provider
    * Use EC2 as the service name
    * For the event type, choose *stage change notification*

3. Use the previously created SNS topic as the target.

4. Subscribe to the SNS topic using your email address
    * confirm subscription in your email inbox.

5. Stop the instance and verify everything is working.


