data "archive_file" "zip_the_python_code" {
  type        = "zip"
  source_dir  = "./pp.py"
  output_path = "./pp.zip"

}

resource "aws_lambda_function" "test_lambda" {
  filename      = "./pp.zip"
  function_name = var.function_name
  role          = var.role
  handler       = var.handler
  runtime       = "nodejs18.x"
}

#"index.handler"