locals {
  lambda_zip_location = "outputs/simple.zip"

}

data "archive_file" "simple" {
  type        = "zip"
    source_file = "simple.py"
      output_path = "local.lambda_zip_location"
      }

resource "aws_lambda_function" "test_lambda" {
  filename      = "local.lambda_zip_location"
    function_name = "welcome"
      role          = aws_iam_role.lambdaa-role.arn
        handler       = "simple.hello"

	  # The filebase64sha256() function is available in Terraform 0.11.12 and later
	    # For Terraform 0.11.11 and earlier, use the base64sha256() function and the file() function:
	      # source_code_hash = "${base64sha256(file("lambda_function_payload.zip"))}"
	       # source_code_hash = filebase64sha256("lambda_function_payload.zip")

		  runtime = "python3.8"

 }		
