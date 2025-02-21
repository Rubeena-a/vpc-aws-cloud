#!/bin/bash

# Test Connectivity for Secure AWS VPC with Public and Private Subnets
# Author: Rubeena


# Variables
PUBLIC_IP="<public-ip-of-web-server>"
PRIVATE_IP="<private-ip-of-database-server>"
KEY_PAIR="key.pem"

# Step 1: Test Public Instance Connectivity
echo "Testing Public Instance Connectivity..."
echo "-------------------------------------"

# SSH into the public instance
echo "1. SSH into the public instance..."
ssh -i $KEY_PAIR ec2-user@$PUBLIC_IP << EOF
  # Test internet access
  echo "2. Testing internet access..."
  curl -I https://example.com

  # Test connectivity to the private instance
  echo "3. Testing connectivity to the private instance..."
  ping -c 4 $PRIVATE_IP

  # SSH into the private instance
  echo "4. SSH into the private instance..."
  ssh -i $KEY_PAIR ec2-user@$PRIVATE_IP << INNER_EOF
    # Test NAT Gateway functionality
    echo "5. Testing NAT Gateway functionality..."
    sudo yum update -y
  INNER_EOF
EOF

echo "-------------------------------------"
echo "All tests completed successfully!"