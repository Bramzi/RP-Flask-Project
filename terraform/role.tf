resource "aws_iam_role" "role" {
  name = "RP-k8s-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}
data "aws_iam_policy" "admin-access" {
  arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_policy_attachment" "admin-role-policy-attach" {
  name       = "k8s-admin-access"
  roles      = [aws_iam_role.role.name]
  policy_arn = data.aws_iam_policy.admin-access.arn
}

resource "aws_iam_instance_profile" "k8s-profile" {
  name = "k8s-adm-profile"
  role = aws_iam_role.role.name
}