## Goal

A collection of labs designed for getting some hands-on experience with the
service required to pass the AWS Sysops certification.

## Quick note about the Terraform implementation

This is not, by any way or means, an implementation of a successfull deployment strategy
through Terraform. I'll try to keep everything modularized, but deployment will happen 
"as-a-whole" instead of the preferred approach which is to have sepparate subgroups for each
infra resource (for blast-radius reduction, readability, maintainability, etc).
