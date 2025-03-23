/* 
Archive the script
*/
data "archive_file" "python_lambda_package" {
  type = "zip"
  source_file = "${path.module}/python-code/redirect.py"
  output_path = "http-redirect-lambda.zip"
}

/*
  Create the lambda function
*/
resource "aws_lambda_function" "test_lambda_function" {
    function_name = "lambdaTest"
    
    filename      = "http-redirect-lambda.zip"
    source_code_hash = data.archive_file.python_lambda_package.output_base64sha256
    role          = aws_iam_role.lambda_role.arn
    runtime       = "python3.8"
    handler       = "redirect.lambda_handler"
    timeout       = 10
}

resource "aws_lambda_function_url" "function" {
    function_name      = aws_lambda_function.function.function_name
    authorization_type = "NONE"
}