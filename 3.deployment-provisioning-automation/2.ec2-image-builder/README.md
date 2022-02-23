## Create a pipeline for creating a new Golden Image

EC2 Image Builder is a service to create new golden images based on a  base operating system and a set of 
packages that we reuqire the instances to have. Usually, this is because of governance, or security kind of compliance requirements, but it is also about High availability.

In the context of Resilience, you can create custom AMI's that come pre-configured with applications, so they are way much faster to boot. This is specially usefull when you're using things like Auto Scaling Groups along with common EC2, in which you still need to define a way to deploy an application on top of it. One cool thing to note is that you can also use
Image Builder to create Docker Images.


## Instructions

1. Create an IAM Role for permissins to EC2 Image Builder
2. Create an Image Pipeline
3. Execute the pipeline
4. View / use the new image


## Lab overview

1. You'll see the Image Bulider pipeline in the AWS Console:

![Pipeline](https://github.com/dbgoytia/sysops-training/blob/cd904848a5c3a0f3e9bfde7158c75633e842b23c/3.deployment-provisioning-automation/2.ec2-image-builder/pipeline.png?raw=true)


2. Once you trigger the pipeline, you'll see an instance being spin up for building your custom AMI.

![Build Instance](https://github.com/dbgoytia/sysops-training/blob/cd904848a5c3a0f3e9bfde7158c75633e842b23c/3.deployment-provisioning-automation/2.ec2-image-builder/instance.png?raw=true)

3. Once the new image has been built, you'll see a new EC2 used for testing purposes. Remember you can
define custom tests for your Images.

![Test Instance](https://github.com/dbgoytia/sysops-training/blob/cd904848a5c3a0f3e9bfde7158c75633e842b23c/3.deployment-provisioning-automation/2.ec2-image-builder/testing.png?raw=true)

4. After testing finishes, you'll be able to see your Image under EC2 > AMI, and filter by "Owned by me"

![AMI Owned by me](https://github.com/dbgoytia/sysops-training/blob/cd904848a5c3a0f3e9bfde7158c75633e842b23c/3.deployment-provisioning-automation/2.ec2-image-builder/ec2_ami.png?raw=true)

or you can see it inside the EC2 Image Builder Dashboard inside "Images"

![AMI Image EC2 Image Builder](https://github.com/dbgoytia/sysops-training/blob/cd904848a5c3a0f3e9bfde7158c75633e842b23c/3.deployment-provisioning-automation/2.ec2-image-builder/image_imagebuilder.png?raw=true)


5. And the image is now showing as available inside the pipeline
![Availability status](https://github.com/dbgoytia/sysops-training/blob/33e29341a341071f2c749efaf2a299c5b47e551f/3.deployment-provisioning-automation/2.ec2-image-builder/availability.png?raw=true)