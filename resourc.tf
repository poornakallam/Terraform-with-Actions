
resource "aws_iam_role_policy" "test_policy" {
  name = "test_policy"
    role = aws_iam_role.lambdaa-role.id

      # Terraform's "jsonencode" function converts a
        # Terraform expression result to valid JSON syntax.
	  policy = jsonencode({
	      Version = "2012-10-17"
	          Statement = [
		        {
			        Action = [
				          "logs:*",
					          ]
						          Effect   = "Allow"
							          Resource = "*"
								        },
									    ]
									      })
									      }
resource "aws_iam_role" "lambdaa-role" {
  name = "lambdaa-role"
                                                                     
  assume_role_policy = file("lambda_assumepolicy.json")
    }
  
