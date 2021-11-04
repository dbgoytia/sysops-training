# Deploy a test VPC
module "vpc" {
  source = "git@github.com:dbgoytia/vpc-tf-module.git?ref=v0.0.1"

  region                = "us-east-1"
  name                  = "test-vpc"
  azs                   = ["us-east-1a", "us-east-1b", "us-east-1c"]
  vpc_cidr_block        = "10.255.0.0/17"
  public_subnets_cidrs  = ["10.255.96.0/21", "10.255.104.0/21", "10.255.112.0/21"] #left over 10.255.120.0/21
  private_subnets_cidrs = ["10.255.0.0/19", "10.255.32.0/19", "10.255.64.0/19"]
}


# Launch an ec2 instance
module "ec2" {
  source = "git@github.com:dbgoytia/ec2-tf-module.git?ref=v0.0.2"

  ami                         = "ami-02e136e904f3da870"
  instance_type               = "t2.micro"
  subnet_id                   = module.vpc.public_subnets_ids[0]
  az                          = "us-east-1a"
  associate_public_ip_address = true
  region                      = "us-east-1"
  name                        = "test-ec2"
}

# Create an SNS topic
module "sns" {
  source = "git@github.com:dbgoytia/sns-tf-module.git?ref=v0.0.1"

  env    = "dev"
  name   = "test-sns"
  region = "us-east-1"

}