resource "aws_s3_bucket" "jay_bucket" {
  bucket = "${var.project_name}-bucket-bpantala"

  tags = {
    Name        = "jay-bucket-bpantala"
    Environment = "Dev"
    CreatedBy = "jay@some.com"
    BillingTeam = "ABC01"
  }
}

resource "aws_iam_role" "test_role" {
  name = "${var.project_name}-ec2-${aws_s3_bucket.jay_bucket.id}-role"
  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    Name        = "jay-ec2-${aws_s3_bucket.jay_bucket.id}-role"
    Environment = "Dev"
    CreatedBy = "jay@some.com"
    BillingTeam = "ABC01"
  }
}

resource "aws_iam_role_policy" "test_policy" {
  name = "test_policy"
  role = aws_iam_role.test_role.id

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "s3:PutObject",
                "s3:GetObject",
                "s3:PutLifecycleConfiguration",
                "s3:ListBucket",
                "s3:GetBucketAcl",
                "s3:GetBucketPolicy"
            ],
            "Resource": [
                "arn:aws:s3:::${aws_s3_bucket.jay_bucket.id}",
                "arn:aws:s3:::${aws_s3_bucket.jay_bucket.id}/*"
            ]
        },
        {
            "Sid": "VisualEditor1",
            "Effect": "Allow",
            "Action": "s3:ListAllMyBuckets",
            "Resource": "*"
        }
    ]
})
}

resource "aws_security_group" "jay_sg" {
  name        = "jay-sg"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = "vpc-017981d0907d9a5b3"

  tags = {
    Name        = "jay-ec2-sg"
    Environment = "Dev"
    CreatedBy = "jay@some.com"
    BillingTeam = "ABC01"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
  security_group_id = aws_security_group.jay_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4_http" {
  security_group_id = aws_security_group.jay_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_instance" "web" {
  ami           = "ami-0453ec754f44f9a4a"
  instance_type = "t2.micro"
  key_name = "all-purpose-server-key"
  vpc_security_group_ids = [ aws_security_group.jay_sg.id ]

  tags = {
    Name        = "jay-ec2-instance"
    Environment = "Dev"
    CreatedBy = "jay@some.com"
    BillingTeam = "ABC01"
  }
}
