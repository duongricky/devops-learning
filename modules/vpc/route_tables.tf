
resource "aws_route_table" "public_route_table" {
    vpc_id = aws_vpc.practice_vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.practice_igw.id
    }

    route {
        cidr_block = "10.0.0.0/16"
        gateway_id = "local"
    }
}

resource "aws_route_table_association" "public_subnet_1_association" {
    subnet_id = aws_subnet.public_subnet_1.id
    route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "public_subnet_2_association" {
    subnet_id = aws_subnet.public_subnet_2.id
    route_table_id = aws_route_table.public_route_table.id
}

// TBU:
// - Create a route table for private subnets and associate it with the private subnets
// - Create a Nat Gateway in one of the public subnets and add a route to the private route table to allow outbound internet access for instances in the private subnets


resource "aws_route_table" "private_route_table" {
    vpc_id = aws_vpc.practice_vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.practice_nat_gateway.id
    }
}

resource "aws_route_table_association" "private_subnet_1_association" {
    subnet_id = aws_subnet.private_subnet_1.id
    route_table_id = aws_route_table.private_route_table.id
}

resource "aws_route_table_association" "private_subnet_2_association" {
    subnet_id = aws_subnet.private_subnet_2.id
    route_table_id = aws_route_table.private_route_table.id
}