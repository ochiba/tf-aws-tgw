data "aws_ssm_parameter" "amzn2_ami" {
  name = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
}

resource "aws_instance" "demo" {
  ami                  = data.aws_ssm_parameter.amzn2_ami.value
  instance_type        = "t2.micro"
  subnet_id            = var.subnet_ids.private[0]
  security_groups      = [aws_security_group.ec2.id]
  iam_instance_profile = aws_iam_instance_profile.demo.name

  tags = { Name = "${var.stack_prefix}-ec2-demo" }
}
