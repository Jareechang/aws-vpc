provider "aws" {
    version = "~> 3.12.0"
    region  = "${var.aws_region}"
}

resource "aws_vpc" "main" {
    cidr_block       = "10.0.0.0/16"
    instance_tenancy = "default"

    tags = {
        Name = "vpc-test"
    }
}

## Public


resource "aws_subnet" "public_1a" {
    vpc_id     = aws_vpc.main.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "us-east-1a"

    tags = {
        Name = "public-1a"
    }
}

resource "aws_subnet" "public_1b" {
    vpc_id     = aws_vpc.main.id
    cidr_block = "10.0.2.0/24"
    availability_zone = "us-east-1b"

    tags = {
        Name = "public-1b"
    }
}


## Private

## App subnets 

resource "aws_subnet" "app_1a" {
    vpc_id     = aws_vpc.main.id
    cidr_block = "10.0.11.0/24"
    availability_zone = "us-east-1a"

    tags = {
        Name = "app-1a"
    }
}

resource "aws_subnet" "app_1b" {
    vpc_id     = aws_vpc.main.id
    cidr_block = "10.0.12.0/24"
    availability_zone = "us-east-1b"

    tags = {
        Name = "app-1b"
    }
}

resource "aws_subnet" "db_1a" {
    vpc_id     = aws_vpc.main.id
    cidr_block = "10.0.21.0/24"
    availability_zone = "us-east-1a"

    tags = {
        Name = "db-1a"
    }
}

resource "aws_subnet" "db_1b" {
    vpc_id     = aws_vpc.main.id
    cidr_block = "10.0.22.0/24"
    availability_zone = "us-east-1b"

    tags = {
        Name = "db-1b"
    }
}

## IGW

resource "aws_internet_gateway" "main" {
    vpc_id = aws_vpc.main.id

    tags = {
        Name = "igw-main"
    }
}

## Routing

resource "aws_route_table" "rt_public" {
    vpc_id = aws_vpc.main.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.main.id
    }

    tags = {
        Name = "rt-public-1a"
    }
}

resource "aws_route_table_association" "public_1a" {
    subnet_id      = aws_subnet.public_1a.id
    route_table_id = aws_route_table.rt_public.id
}

resource "aws_route_table_association" "public_1b" {
    subnet_id      = aws_subnet.public_1b.id
    route_table_id = aws_route_table.rt_public.id
}
