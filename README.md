# AWS VPC with Public and Private Subnets

This project involves designing a secure AWS VPC with public and private subnets, implementing best security practices, and ensuring controlled access.

## Prerequisites

- AWS Account
- Basic knowledge of AWS networking components
- AWS CLI installed and configured

# Configurations

- VPC NAME: Secure-VPC-Architecture
- IGW NAME: My-Dev-IGW (An Internet Gateway can only be attached to one VPC)
-  4 subnets (2 public, 2 private) across 2 Availability Zones (AZs) for high availability.
	- Public Subnets:
      - Public-Subnet-A1 (AZ: us-east-1a): 10.0.1.0/24 
      - Public-Subnet-B1 (AZ: us-east-1b): 10.0.2.0/24
	- Private Subnets:
      - Private-Subnet-A2 (AZ: us-east-1a): 10.0.3.0/24 
      - Private-Subnet-B2 (AZ: us-east-1b): 10.0.4.0/24

- NAT GW: Dev-NAT-GW attached to subnet: Public-Subnet-A1 
- Configure Route Table:
    - Public-RT: Subnet Associations: Public-Subnet-A1, Public-Subnet-B1.,
    - Private_RT: Subnet Associations: Private-Subnet-A2, Private-Subnet-B2  

- Configure Security Groups (Least Privilege):
	- Web Server SG (public instances):
      - Inbound Rules:
        - HTTP (80) from 0.0.0.0/0
        - HTTPS (443) from 0.0.0.0/0
        - SSH (22) from YourIP/32
      - Outbound Rules: All traffic allowed.

	- Database SG (private instances):
      - Inbound Rules:
        - MySQL (3306) from Web Server SG
      - Outbound Rules: All traffic allowed.

- Configure NACL:
  - Public Subnet NACL:
      - Inbound Rules:
          - 100: Allow HTTP (80) from 0.0.0.0/0
          - 110: Allow HTTPS (443) from 0.0.0.0/0
          - 120: Allow SSH (22) from YourIP/32
          - *: Deny all
      - Outbound Rules: Allow all.
   - Private Subnet NACL:
       - Inbound Rules:
            - 100: Allow ephemeral ports (1024-65535) from Public Subnet CIDR
            - *: Deny all
       - Outbound Rules: Allow all.   
    
- Launch EC2 Instances:
    - Public EC2 (Web Server):
        - AMI: Amazon Linux 2
        - Instance Type: t2.micro
        - Subnet: Public-Subnet-A1
        - Security Group: Web Server SG
    - Private EC2 (Database):
        - AMI: Amazon Linux 2
        - Instance Type: t2.micro
        - Subnet: Private-Subnet-A2
        - Security Group: Database SG
        
- Test Connectivity:
    - Replace `<public-ip-of-web-server>` with the public IP of your web server (public instance).
    - Replace `<private-ip-of-database-server>` with the private IP of your database server (private instance).
    - Replace key.pem with the name of your private key file.
      
    - Run the following command to make the script executable: `chmod +x test_connectivity.sh`
    - Execute the script to test connectivity: `./test_connectivity.sh`

## **Tools Used**
- **AWS Services**: VPC, EC2, IGW, NAT Gateway, Security Groups, NACLs.
- **Networking Tools**: Subnetting, CIDR blocks, route tables.
- **Testing Tools**: SSH, `curl`, `ping`.  

## **Impact**
- **Enhanced Security**: Implemented least-privilege access using Security Groups and NACLs.
- **High Availability**: Designed subnets across multiple AZs for fault tolerance.
- **Scalability**: Built a modular architecture that can scale with business needs.  

## **Author**
Rubeena Shaik
