output "network" {
  value = {
    vpc_id = aws_vpc.practice_vpc.id

    public_subnets = {
      public_subnet_1_id = aws_subnet.public_subnet_1.id
      public_subnet_2_id = aws_subnet.public_subnet_2.id
    }

    private_subnets = {
      private_subnet_1_id = aws_subnet.private_subnet_1.id
      private_subnet_2_id = aws_subnet.private_subnet_2.id
    }

    nat_gateway_id = aws_nat_gateway.practice_nat_gateway.id
    internet_gateway_id = aws_internet_gateway.practice_igw.id
  }
}