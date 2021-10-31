resource "aws_security_group" "ec2" {
  name        = "${var.stack_prefix}-sg-ec2"
  description = "for EC2"
  vpc_id      = var.vpc.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow All ICMP"
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "vpce" {
  name        = "${var.stack_prefix}-sg-vpce"
  description = "for VPC Endpoint"
  vpc_id      = var.vpc.id

  ingress {
    description     = "TLS from EC2"
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    security_groups = [aws_security_group.ec2.id]
  }
}
