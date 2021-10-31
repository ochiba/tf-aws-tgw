resource "aws_iam_instance_profile" "demo" {
  name = "${var.stack_prefix}-ec2_profile-demo"
  role = aws_iam_role.ec2_demo.name
}

resource "aws_iam_role" "ec2_demo" {
  name = "${var.stack_prefix}-EC2Demo"
  path = "/"
  assume_role_policy = jsonencode({
    "Statement" = [
      {
        "Effect" = "Allow"
        "Action" = "sts:AssumeRole"
        "Principal" = {
          "Service" = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

data "aws_iam_policy" "ssm_managed_instance_core" {
  name = "AmazonSSMManagedInstanceCore"
}

resource "aws_iam_role_policy_attachment" "ec2_demo_ssm" {
  role       = aws_iam_role.ec2_demo.name
  policy_arn = data.aws_iam_policy.ssm_managed_instance_core.arn
}
