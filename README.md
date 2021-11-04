## Goal

A collection of labs designed for getting some hands-on experience with the
service required to pass the AWS Sysops certification.

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

## How to use this hands-on labs

Go to the appropiate directory location (cd into it), and and start the commands listed in each section.


## Disclaimer

Beware that using some of this components might incur in some extra costs to your AWS resources. 
I'm doing this labs on my own and not at all related to my current employer, and is not meant to replace any formal
AWS Training, rather complement it.
