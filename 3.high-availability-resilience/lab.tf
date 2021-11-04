/*
    VPC CONFIGURATION
*/


// VPC for us-east-1
module "vpc" {
  source = "git@github.com:dbgoytia/vpc-tf-module.git?ref=v0.0.1"

  region                = "us-east-1"
  name                  = "test-vpc"
  azs                   = ["us-east-1a", "us-east-1b", "us-east-1c"]
  vpc_cidr_block        = "10.255.0.0/17"
  public_subnets_cidrs  = ["10.255.96.0/21", "10.255.104.0/21", "10.255.112.0/21"] #left over 10.255.120.0/21
  private_subnets_cidrs = ["10.255.0.0/19", "10.255.32.0/19", "10.255.64.0/19"]
}

// VPC for us-west-2
module "vpc_two" {
  source = "git@github.com:dbgoytia/vpc-tf-module.git?ref=v0.0.1"

  region                = "us-west-2"
  name                  = "test-vpc-two"
  azs                   = ["us-west-2a", "us-west-2b", "us-west-2c"]
  vpc_cidr_block        = "10.255.0.0/17"
  public_subnets_cidrs  = ["10.255.96.0/21", "10.255.104.0/21", "10.255.112.0/21"] #left over 10.255.120.0/21
  private_subnets_cidrs = ["10.255.0.0/19", "10.255.32.0/19", "10.255.64.0/19"]
}

/*
    ENI + EIP's configuration
    Will leave this here since you wouldn't normaly
    provision neither ENI's or EIPS without any other
    resource associated to it
*/
resource "aws_network_interface" "one" {
  provider  = aws.east
  subnet_id = module.vpc.public_subnets_ids[0]
}

resource "aws_network_interface" "two" {
  provider  = aws.west
  subnet_id = module.vpc_two.public_subnets_ids[1]
}

resource "aws_eip" "one" {
  provider          = aws.east
  vpc               = true
  network_interface = aws_network_interface.one.id
}

resource "aws_eip" "two" {
  provider          = aws.west
  vpc               = true
  network_interface = aws_network_interface.two.id
}

/*
    ROUTE 53
    Route 53 module is still under construction
*/

resource "aws_route53_zone" "main" {
  provider = aws.east
  name     = "examplelatencyr.com"
  vpc {
    vpc_id = module.vpc.vpc_id 
    vpc_region = "us-east-1"
  }
  vpc {
    vpc_id = module.vpc_two.vpc_id
    vpc_region = "us-west-2"
  }
}

resource "aws_route53_record" "one" {
  provider = aws.east
  zone_id  = aws_route53_zone.main.zone_id
  name = "test.examplelatencyr.com"
  set_identifier = "east"
  type     = "A"
  ttl      = "300"
  records  = [aws_eip.one.public_ip]
  latency_routing_policy {
    region = "us-east-1"
  }
}

resource "aws_route53_record" "two" {
  provider = aws.west
  zone_id  = aws_route53_zone.main.zone_id
  name = "test.examplelatencyr.com"
  set_identifier = "west"
  type     = "A"
  ttl      = "300"
  records  = [aws_eip.two.public_ip]
  latency_routing_policy {
    region = "us-west-2"
  }
}

# Launch an ec2 instance
module "ec2_primary" {
  source = "git@github.com:dbgoytia/ec2-tf-module.git?ref=v0.0.2"

  ami                         = "ami-02e136e904f3da870"
  instance_type               = "t2.micro"
  subnet_id                   = module.vpc.private_subnets_ids[0]
  az                          = "us-east-1a"
  associate_public_ip_address = true
  region                      = "us-east-1"
  name                        = "ec2-east1"
}

# Launch an ec2 instance
module "ec2_secondary" {
  source = "git@github.com:dbgoytia/ec2-tf-module.git?ref=v0.0.2"

  ami                         = "ami-013a129d325529d4d"
  instance_type               = "t2.micro"
  subnet_id                   = module.vpc_two.private_subnets_ids[0]
  az                          = "us-west-2a"
  associate_public_ip_address = true
  region                      = "us-west-2"
  name                        = "ec2-west2"
}