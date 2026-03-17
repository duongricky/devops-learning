resource "aws_internet_gateway" "practice_igw" {
    vpc_id = aws_vpc.practice_vpc.id
}
