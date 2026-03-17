// Public subnet 1
resource "aws_subnet" "public_subnet_1" {
    vpc_id = aws_vpc.practice_vpc.id
    cidr_block = "10.0.1.0/24"
    map_public_ip_on_launch = true
    availability_zone = "us-east-1a"
}

// Public subnet 2
resource "aws_subnet" "public_subnet_2" {
    vpc_id = aws_vpc.practice_vpc.id
    cidr_block = "10.0.2.0/24"
    availability_zone = "us-east-1b"
}

// Private subnet 1
resource "aws_subnet" "private_subnet_1" {
    vpc_id = aws_vpc.practice_vpc.id
    cidr_block = "10.0.3.0/24"
    availability_zone = "us-east-1a"
}

// Private subnet 2
resource "aws_subnet" "private_subnet_2" {
    vpc_id = aws_vpc.practice_vpc.id
    cidr_block = "10.0.4.0/24"
    availability_zone = "us-east-1b"
}
