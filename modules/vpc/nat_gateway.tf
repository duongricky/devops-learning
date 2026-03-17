resource "aws_nat_gateway" "practice_nat_gateway" {
    allocation_id = aws_eip.nat_eip.id
    subnet_id = aws_subnet.public_subnet_1.id
}
