provider "aws" {
  # ... other configuration ...
	region = "ap-south-1"
	access_key = "AKIA5NHV6MZ6AXPOHIHK"
	secret_key = "K9SCSRF9XQghGU4cfMonVsx9ga6dXOZ1QK1y7QzE"
}

terraform {
	backend "s3" {
	bucket = "terraformsagar"
	key = "workspace-example/terraform.tfstate"
	region = "ap-south-1"
	
	dynamodb_table = "TerraformTest"
	}
}

locals {
	env = "${terraform.workspace}"
}

module "my_vpc" {
	source = "C:/Users/Sagar/Desktop/terraform/dev/vpc"
	vpc_name = "${local.env}"
	sub_name = "${local.env}"
}

module "my_ec2" {
	source = "C:/Users/Sagar/Desktop/terraform/dev/EC2"
#	Subnet_Private = "${module.my_vpc.Subnet_Private}"
	Subnet_Public = "${module.my_vpc.subnet}"
	ec2_name = "${local.env}"
	SGID = "${module.my_sg.sgid}"
}

module "my_sg" {
	source = "C:/Users/Sagar/Desktop/terraform/dev/SG"
	VPCID = "${module.my_vpc.VPCID}"
}

module "my_ig" {
	source = "C:/Users/Sagar/Desktop/terraform/dev/IG"
	ec2_id = "${module.my_ec2.ec2_id}"
	vpcid = "${module.my_vpc.VPCID}"
}

module "my_rt" {
	source = "C:/Users/Sagar/Desktop/terraform/dev/RT"
	vpc_id = "${module.my_vpc.VPCID}"
	IG_ID = "${module.my_ig.IG_ID}"
	subnet_id = "${module.my_vpc.subnet}"
	RT_ID = "${module.my_vpc.RT_ID}"
}
