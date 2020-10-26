# AWS VPC  

Creating a custom vpc (isolated network) which has both public and private access (via subnets).

## Table Of Contents:

- [Introduction](#Introdiction)
- [Quick Start](#quick-start)

## Introduction


Design a custom vpc with public and private access via subnets.

As a quick brief, "custom vpc" is a slightly different than the "default vpc" provided by AWS.
See explanation in [Notes](#notes).

Public will be used for resources to be used by clients (ex. application to serve requests) and private will be for 
resources that are not to be accessible outside of vpc (ex. database / database server).

In addition, support a public bastion host which allows for indirect and secure access to private resources. Mainly, this is for adminstration and operation purposes.

**Core Concepts:**

-  
- Public / private subnets 
- Allow internet access (IGW)
- Bastion host and jumpbox

## Quick Start

**Technologies:**

- AWS VPC 
- AWS Network ACL
- AWS Subnets
- AWS Security groups 
- AWS Internet gateway (IGW)
- AWS EC2 
- Terraform (>= v0.12.24)


## Notes

1. What is the difference between custom and default vpc ?

> Main difference is the default vpc works out of the box by providing access to most things which is suitable for development. Whereas custom VPC is suitable for granular access control by customizing the types of request that can access resources within the network (restrict by ip, request, network type etc)

**Default VPC:**

- A /20 public subnet in each AZ with public IP by default
- Attached Internet gateway (with configuration on route table sending traffic to IGW using 0.0.0.0/0 route)
- Default Security Group with allow all access
- Default Network ACL with allow all access

**Custom VPC:**

- You need to create your own netowrk resources (allocate IP ranges, create subnets and provision gateways and networking  etc)
- You need to handle security (who and/or what can access what)
