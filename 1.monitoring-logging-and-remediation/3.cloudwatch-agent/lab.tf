# Deploy the SSM Parameter. Ideally, this could be either in another standalone repository
# or coming through a pre-build AMI
resource "aws_ssm_parameter" "cwconfig" {
  name  = "AmazonCloudWatch-cwconfig"
  type  = "String"
  value = file("${path.module}/cwatch_config.json")
}

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
  source = "git@github.com:dbgoytia/ec2-tf-module.git?ref=v0.0.3"

  ami                         = "ami-02e136e904f3da870"
  instance_type               = "t2.micro"
  subnet_id                   = module.vpc.public_subnets_ids[0]
  az                          = "us-east-1a"
  associate_public_ip_address = true
  region                      = "us-east-1"
  name                        = "securitylab"

  cloudwatch_agent_enabled = true
  user_data = <<EOF
#!/bin/bash
sudo yum update -y
sudo yum install amazon-cloudwatch-agent -y
sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a fetch-config -m ec2 -s -c ssm:${aws_ssm_parameter.cwconfig.name}
sudo amazon-linux-extras install epel -y
sudo yum install stress -y
EOF
}

# Create the cloudwatch dashboards
resource "aws_cloudwatch_dashboard" "instance_utilization_metrics" {
    dashboard_name = "my-instance-utilization"

    dashboard_body = <<EOF
{
  "widgets": [
    {
      "type": "metric",
      "x": 0,
      "y": 0,
      "width": 12,
      "height": 6,
      "properties": {
        "metrics": [
          [
            "AWS/EC2",
            "CPUUtilization",
            "InstanceId",
            "${module.ec2.instance_id}"
          ]
        ],
        "period": 300,
        "stat": "Average",
        "region": "us-east-1",
        "title": "EC2 Instance CPU"
      }
    },
    {
      "type": "metric",
      "x": 0,
      "y": 0,
      "width": 12,
      "height": 6,
      "properties": {
        "metrics": [
          [
            "AWS/EC2",
            "NetworkPacketsIn",
            "InstanceId",
            "${module.ec2.instance_id}"
          ]
        ],
        "period": 300,
        "stat": "Average",
        "region": "us-east-1",
        "title": "EC2 Network Packets In"
      }
    },
    {
      "type": "metric",
      "x": 0,
      "y": 0,
      "width": 12,
      "height": 6,
      "properties": {
        "metrics": [
          [
            "AWS/EC2",
            "NetworkPacketsOut",
            "InstanceId",
            "${module.ec2.instance_id}"
          ]
        ],
        "period": 300,
        "stat": "Average",
        "region": "us-east-1",
        "title": "EC2 Network Packets Out"
      }
    },
    {
      "type": "metric",
      "x": 0,
      "y": 0,
      "width": 12,
      "height": 6,
      "properties": {
        "metrics": [
          [
            "CWAgent",
            "mem_used_percent",
            "InstanceId",
            "${module.ec2.instance_id}",
            "ImageId",
            "ami-02e136e904f3da870",
            "InstanceType",
            "t2.micro"
          ]
        ],
        "period": 300,
        "region": "us-east-1",
        "title": "Memory"
      }
    }
  ]
}
EOF
}
