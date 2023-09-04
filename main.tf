provider "aws" {
  region = "us-east-1"  # Set your desired AWS region
}

# Create IAM users
resource "aws_iam_user" "iam_users" {
  count = 10  # Create 10 IAM users

  name = "user${count.index + 1}"  # Generate unique usernames
}

# Define IAM policies (customize these policies as needed)
resource "aws_iam_policy" "example_policies" {
  count = 10  # Create 10 different policies

  name        = "example-policy-${count.index + 1}"
  description = "Example policy ${count.index + 1}"

  policy = <<EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": [
          "s3:ListBucket",
          "s3:GetObject"
        ],
        "Resource": [
          "arn:aws:s3:::example-bucket",
          "arn:aws:s3:::example-bucket/*"
        ]
      }
    ]
  }
  EOF
}

# Attach policies to IAM users
resource "aws_iam_user_policy_attachment" "user_policy_attachments" {
  count = 10  # Attach different policies to each user

  user       = aws_iam_user.iam_users[count.index].name
  policy_arn = aws_iam_policy.example_policies[count.index].arn
}

