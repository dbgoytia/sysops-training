#------------------------------------------------------------------------------
# S3 configuration
#------------------------------------------------------------------------------
resource "aws_s3_bucket" "flowlogs_bucket" {
  bucket = "test-vpc-flowlogs-bucket"
  acl    = "private"
  versioning {
    enabled = true
  }
}

#------------------------------------------------------------------------------
# VPC Configuration
#------------------------------------------------------------------------------
module "vpc" {
  source = "git@github.com:dbgoytia/vpc-tf-module.git?ref=v0.0.2"

  region = "us-east-1"
  name                  = "flowlogs-lab"
  azs                   = ["us-east-1a", "us-east-1b", "us-east-1c"]
  vpc_cidr_block        = "10.255.0.0/17"
  public_subnets_cidrs  = ["10.255.96.0/21", "10.255.104.0/21", "10.255.112.0/21"] #left over 10.255.120.0/21
  private_subnets_cidrs = ["10.255.0.0/19", "10.255.32.0/19", "10.255.64.0/19"]

  # Flow logs
  enable_flow_log      = true
  log_destination_type = "s3"
  log_destination      = aws_s3_bucket.flowlogs_bucket.arn
  traffic_type         = "ALL"
}

#------------------------------------------------------------------------------
# NGINX configuration
#------------------------------------------------------------------------------
module "ec2_primary" {
  source = "git@github.com:dbgoytia/ec2-tf-module.git?ref=v0.0.2"

  region                      = "us-east-1"
  ami                         = "ami-02e136e904f3da870"
  instance_type               = "t2.micro"
  subnet_id                   = module.vpc.public_subnets_ids[0]
  az                          = "us-east-1a"
  associate_public_ip_address = true
  name                        = "ec2-nginx"

  user_data =<<EOF
#!/bin/bash
sudo yum update -y
sudo yum install httpd -y
sudo systemctl enable --now httpd
EOF
}