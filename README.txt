# AWS VPC with Public and Private Subnets

This project involves designing a secure AWS VPC with public and private subnets, implementing best security practices, and ensuring controlled access.

## Prerequisites

- AWS Account
- Basic knowledge of AWS networking components
- AWS CLI installed and configured

# Configurations

- VPC NAME: Secure-VPC-Architechture
- IGW NAME: Dev-IGW (An Internet Gateway can only be attached to one VPC)
-  4 subnets (2 public, 2 private) across 2 Availability Zones (AZs) for high availability.
	- Public Subnets:

		Public-Subnet-A1 (AZ: us-east-1a): 10.0.1.0/24

		Public-Subnet-B1 (AZ: us-east-1b): 10.0.2.0/24

	- Private Subnets:

		Private-Subnet-A2 (AZ: us-east-1a): 10.0.3.0/24

		Private-Subnet-B2 (AZ: us-east-1b): 10.0.4.0/24

- NAT GW: Dev-NAT-GW attahed to subnet: Public-Subnet-A1 
- NACL: Private-Subnet-A2-NACL  
	-  associate with Private-Subnet-A2
	-  Add rules to a Private Network ACL:

- Configure Security Groups:
	- Web Server SG (public instances):

		- Inbound:HTTP (80) from 0.0.0.0/0, HTTPS (443) from 0.0.0.0/0
,SSH (22) from your IP (e.g., 123.45.67.89/32)
		- Outbound: Allow all.

	- Database SG (private instances):

		- Inbound: MySQL (3306) from Web Server SG.

		- Outbound: Allow all.