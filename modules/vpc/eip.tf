resource "aws_eip" "nat_eip" {
  domain = "vpc"

  tags = {
    Name = "practice-nat-eip"
  }
}
