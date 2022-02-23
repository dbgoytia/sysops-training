# Generate a role for using ImageBuilder
resource "aws_iam_role" "image_builder_lab" {
  name = "image_builder_lab"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}


resource "aws_iam_role_policy_attachment" "image_builder_policy_attach" {
  role       = aws_iam_role.image_builder_lab.name
  policy_arn = "arn:aws:iam::aws:policy/EC2InstanceProfileForImageBuilder"
}


resource "aws_iam_role_policy_attachment" "ssm_core_policy_attachment" {
  role       = aws_iam_role.image_builder_lab.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}


## Generate a Pipeline for Image Builder

data "aws_partition" "current" {}

data "aws_region" "current" {}


# Recipie
resource "aws_imagebuilder_image_recipe" "recipe" {

  component {
    component_arn = "arn:aws:imagebuilder:${data.aws_region.current.name}:aws:component/update-linux/x.x.x" # Update the components to latest security patches
  }

  name         = "MyRecipe"
  parent_image = "arn:${data.aws_partition.current.partition}:imagebuilder:${data.aws_region.current.name}:aws:image/amazon-linux-2-x86/x.x.x"
  version      = "1.0.0"
}


# Test infra configuration
resource "aws_iam_instance_profile" "test_profile" {
  name = "test_profile"
  role = aws_iam_role.image_builder_lab.name
}


resource "aws_imagebuilder_infrastructure_configuration" "test_image" {
  description                   = "Infra for testing golden image"
  instance_profile_name         = aws_iam_instance_profile.test_profile.name
  instance_types                = ["t2.nano", "t3.micro"]
  name                          = "test_image_infra"
#   security_group_ids            = [aws_security_group.example.id]
#   sns_topic_arn                 = aws_sns_topic.example.arn
  terminate_instance_on_failure = true
}


# Pipeline
resource "aws_imagebuilder_image_pipeline" "pipeline" {
  image_recipe_arn                 = aws_imagebuilder_image_recipe.recipe.arn
  infrastructure_configuration_arn = aws_imagebuilder_infrastructure_configuration.test_image.arn
  name                             = "MyImageBuilderPipeline"

  # no schedule block for manual deployment
}


# "arn:aws:imagebuilder:${data.aws_region.current.name}:aws:component/simple-boot-test-linux/x.x.x"