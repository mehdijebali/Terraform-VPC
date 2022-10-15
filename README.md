# VPC Provisioning with Terraform
In this demo, we will create AWS VPC with respect to the following diagram:
![](./Lab_Results/Screenshot%20from%202022-08-30%2011-50-04.png)
## About VPC 
Amazon Virtual Private Cloud (Amazon VPC) is the networking layer for AWS that enables you to launch AWS resources into a virtual network that you've defined. It is logically isolated from other virtual networks in the AWS Cloud.
For Fresh account, Amazon have default VPC Network. But the best practice is to create your own VPC with your settings and configuration.
The basic key points of AWS VPC that we will provision later are the following:
#### Subnet
A range of IP addresses in your VPC.You can create onr or more subnets in a VPC by specifying a range of IP addresses in the form of CIDR (Classless Inter-Domain Routing) block.
- If a subnet's traﬃc is routed to an internet gateway, the subnet is known as a public subnet.
- If a subnet doesn't have a route to the internet gateway, the subnet is known as a private subnet.
#### Route table
A set of rules, called routes, that are used to determine where network traﬃc is directed.
#### Internet gateway
A gateway that you attach to your VPC to enable communication between resources in your VPC and the internet. As a result, instances in public subnet can reach the internet through a route to the internet gateway.
#### Network Address Translation (NAT)
NAT is the porcess of routing specific IP Addresses into a predefined IP Address (Router). In fact, instances in a private subnet can connect to services outside the VPC. indeed, we can access to internet from subnet. In contrast, external sources cannot initiate a connection with "private" instances.  
## Instructions
1. clone the project 
```
git clone https://github.com/mehdijebali/Terraform-VPC.git
```
2. Export your AWS Credentials
```
export AWS_ACCESS_KEY_ID=AKIAIOSFODNN7EXAMPLE
export AWS_SECRET_ACCESS_KEY=wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
export AWS_DEFAULT_REGION=us-west-2
```
3. In the project root directory, initiate Terraform in order to install the declared provider in `provider.tf` file
```
terraform init
```
4. If you want to see your provisionning details, run the following command
```
terraform plan
```
5. Apply modifications
```
terraform apply
```
## Expected Results