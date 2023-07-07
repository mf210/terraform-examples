provider "aws" {
    region = "eu-west-3"
    access_key = "ACCESS_KEY"
    secret_key = "SECRET_KEY"
}


variable "subnet_cidr_block" {
    description = "subnet cidr block"
    default = "10.0.10.0/24"
    type = string
}

variable "cidr_blocks" {
    description = "cidr blocks for vpc and subnets"
    type = list(string)

}

variable "cidr_blocks_objs" {
    description = "cidr blocks and names for vpc and subnets"
    type = list(object({
        cidr_block = string
        name = string
    }))
}

variable "vpc_cidr_block" {
    description = "vpc cidr block"
}

resource "aws_vpc" "development-vpc" {
    cidr_block = var.vpc_cidr_block
    tags = {
        Name: "development",
        vpc_env: "dev"
    }
}

resource "aws_subnet" "dev-subnet-1" {
    vpc_id = aws_vpc.development-vpc.id
    cidr_block = var.cidr_blocks[0]
    availability_zone = "eu-west-3a"
    tags = {
        Name: "subnet-1-dev"
    }
}

data "aws_vpc" "existing_vpc" {
    default = true
}

resource "aws_subnet" "dev-subnet-2" {
    vpc_id = data.aws_vpc.existing_vpc.id
    cidr_block = var.cidr_blocks_objs[1].cidr_block
    availability_zone = "eu-west-3a"
    tags = {
        Name: var.cidr_blocks[1].name
    }
}

output "dev-vpc-id" {
    value = aws_vpc.development-vpc.id
}

output "dev-subnet-id" {
    value = aws_subnet.dev-subnet-1.id
}