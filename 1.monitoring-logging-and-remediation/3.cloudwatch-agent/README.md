## Goal

The goal of this lab is to pick up custom metrics that we can store in CloudWatch using the CloudWatch agent


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

## To destroy

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


