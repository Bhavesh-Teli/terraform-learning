# Create VPC
resource "aws_vpc" "tf_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "tf-vpc"
  }
  
}

#Private subnet
resource "aws_subnet" "tf_private_subnet" {
  vpc_id     = aws_vpc.tf_vpc.id
  cidr_block = "10.0.1.0/24"
    tags = {
        Name = "private-subnet"
    }   
}

#Public subnet
resource "aws_subnet" "tf_public_subnet" {
  vpc_id     = aws_vpc.tf_vpc.id
  cidr_block = "10.0.2.0/24"
    tags = {
        Name = "public-subnet"
    }   
}
#Internet Gateway`
resource "aws_internet_gateway" "tf_igw" {
  vpc_id = aws_vpc.tf_vpc.id
    tags = {
        Name = "tf-igw"
    }   
}

#Route Table
resource "aws_route_table" "tf_rt" {
  vpc_id = aws_vpc.tf_vpc.id
  route  {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.tf_igw.id
  }
}

#Route Table Association

resource "aws_route_table_association" "tf_rta" {
    subnet_id = aws_subnet.tf_public_subnet.id
    route_table_id = aws_route_table.tf_rt.id
  
}
