resource aws_instance "practice_instance" {
  ami           = "ami-02dfbd4ff395f2a1b"
  instance_type = "t2.micro"
  subnet_id     = var.network.public_subnets.public_subnet_1_id
  iam_instance_profile = var.iam_role.ec2_instance_profile_name

  vpc_security_group_ids = [aws_security_group.practice_sg.id]
}
