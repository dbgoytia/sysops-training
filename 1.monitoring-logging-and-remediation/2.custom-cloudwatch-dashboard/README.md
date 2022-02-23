## Goal

Goal of this demonstration is to understand how to deploy a custom CloudWatch dashboard
that utilizes some widgets to help us get a better view of our environments. You'll also
have the chance to use AWS SSM to log in to the instances.

The metrics we're going to see are:
* CPUUtilization
* NetworkPacketsIn
* NetworkPacketsOut

We're going to launch an EC2 instance, generate some activity, and capture the metrics
listed above to see the usage.


## Final result:

![EC2 Dashboard](https://github.com/dbgoytia/sysops-training/blob/main/1.monitoring-logging-and-remediation/2.custom-cloudwatch-dashboard/dashboard.png?raw=true)


## Objective

1. Launch the terraform code in here.

    ```
    # Initialize terraform providers
    $ terraform init
    ```

    ```
    # Create a plan for the lab, validate everything's ok.
    $ terraform plan -out tfplan 
    ```

    ```
    # Launch terraform
    $ terraform apply tfplan
    ```

2. Connect to the instance and generate some random activity. Let this run for about 10 seconds.

    ```
    # Log In to the EC2 Instance
    $ aws ssm start-session --target <your-instance-id> --region us-east-1

    # Will generate high spikes in CPU Utilization
    $ while true; do echo 'hello'; done;

    # Stop the operation usint CTRL+C
    ```


3. What can you see on the dashboards? What else would you add to these? What would happen if this was part of an ASG?

## To destroy

1. Destroy the terraform code using

```
# Review what you're about to destroy
$ terraform plan -out tfplan -destroy
```

```
# Destroy the resources
$ terraform apply tfplan
```


## Cool things I've noted


