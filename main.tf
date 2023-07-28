locals {
  lambda_map = { for lambda in var.lambdas : lambda.name => lambda }
}

module "lambdas" {
  source        = "./modules/lambda"
  for_each      = local.lambda_map
  function_name = each.value["name"]
  handler       = each.value["handler"]
  role          = aws_iam_role.lambdaa-role.arn
}


resource "aws_iam_role" "lambdaa-role" {
  name               = "lambdaa-role"
  assume_role_policy = <<EOF
  {
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "sts:AssumeRole"
            ],
            "Principal": {
                "Service": [
                    "lambda.amazonaws.com"
                ]
            }
        }
    ]
}
EOF
}

resource "aws_iam_policy" "policy" {
  name   = "lambda-policy"
  policy = data.aws_iam_policy_document.lambdapolicy.json
}


data "aws_iam_policy_document" "lambdapolicy" {
  statement {
    effect    = "Allow"
    actions   = ["*"]
    resources = ["*"]
  }
}


resource "aws_iam_role_policy_attachment" "function" {
  role       = aws_iam_role.lambdaa-role.name
  policy_arn = aws_iam_policy.policy.arn
}

