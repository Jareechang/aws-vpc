# AWS VPC  

Creating a multi AZ custom vpc (isolated network) which has both public and private access (via subnets).

## Table Of Contents:

- [Introduction](#Introdiction)
- [Quick Start](#quick-start)

## Introduction


Design a multi AZ custom vpc with public and private access via subnets.

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


**Setting up resources:**


1. Add AWS secret and key to your environment

```

```

2. Export your ip address

```
export TF_VAR_local_ip_address=<your-ip-address>
```

3. Run terraform 

```

# Run the plan, and if it looks good then proceed
terraform plan


# Run the execution of setting up resources
terrfaorm apply
```

Done.

#### Accessing Bastion (public secure instance)


1. Create a `ssh-key.pem` file and copy `ssh-key` output into the file  

2. Update permission of the `ssh-key.pem` file  

```sh
chmod 400 ssh-key.pem
```

3. copy the `public ip` of instnace and ssh into it   

```sh
ssh -i ./ssh-key.pem ec2-user@<bastion_instance_ip>
```

4. Verify internet access (via internet gateway)  

```sh
# Get current ip address
curl ifconfig.me.


# Try pinging and receiving packets, It should work fine 
ping 1.1.1.1

# Example
#PING 1.1.1.1 (1.1.1.1) 56(84) bytes of data.
#64 bytes from 1.1.1.1: icmp_seq=1 ttl=54 time=0.728 ms
#64 bytes from 1.1.1.1: icmp_seq=2 ttl=54 time=0.709 ms
#64 bytes from 1.1.1.1: icmp_seq=3 ttl=54 time=0.782 ms
```

#### Accessing Private instance (private)


1. Add key to key-chain 

```sh

ssh-add -k ssh-key.pem (your pem file)

```

2. Verify the key is added 

```sh
ssh-add -L
```

3. ssh into the basion instance 

```sh
ssh -A ec2-user@<bastion_instance_ip>
```

4. Look up in console a the private, and ssh into the instance

```sh
# For example
ssh ec2-user@10.0.11.186
```

5. Verify no internet access

```
# It should be stuck
ping 1.1.1.1
```
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
