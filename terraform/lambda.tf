data "archive_file" "presigned_url_zip" {
  type        = "zip"
  source_file = "${path.module}/../lambda/presigned_url.py"
  output_path = "/tmp/presigned_url.zip"
}


resource "aws_lambda_function" "generate_presigned_url_lambda" {

  function_name    = "${var.env}-presigned_url-lambda"
  role             = aws_iam_role.generate_presigned_url_lambda_role.arn
  handler          = "presigned_url.lambda_handler"
  runtime          = "python3.11"
  timeout          = 30
  memory_size      = 128
  layers           = [var.layer_arn]
  filename         = data.archive_file.presigned_url_zip.output_path
  source_code_hash = data.archive_file.presigned_url_zip.output_base64sha256
  environment {
    variables = {
      SOURCE_BUCKET = aws_s3_bucket.file_to_be_processed.bucket
      TABLE_NAME    = aws_dynamodb_table.image_upload_jobs.name
    }
  }


}



data "archive_file" "extract_s3_object_metadata_zip" {
  type        = "zip"
  source_file = "${path.module}/../lambda/extract_s3_object_metadata.py"
  output_path = "/tmp/extract_s3_object_metadata.zip"
}

resource "aws_lambda_function" "extract_s3_object_metadata_lambda" {

  function_name    = "${var.env}-extract_s3_object_metadata"
  role             = aws_iam_role.generate_presigned_url_lambda_role.arn
  handler          = "extract_s3_object_metadata.lambda_handler"
  runtime          = "python3.11"
  timeout          = 30
  memory_size      = 128
  layers           = [var.layer_arn]
  filename         = data.archive_file.extract_s3_object_metadata_zip.output_path
  source_code_hash = data.archive_file.extract_s3_object_metadata_zip.output_base64sha256
  environment {
    variables = {
      SOURCE_BUCKET = aws_s3_bucket.file_to_be_processed.bucket
    }
  }


}




data "archive_file" "generate_image_to_text_zip" {
  type        = "zip"
  source_file = "${path.module}/../lambda/generate_image_to_text.py"
  output_path = "/tmp/generate_image_to_text.zip"
}


resource "aws_lambda_function" "generate_image_to_text_lambda" {

  function_name    = "${var.env}-generate_image_to_text"
  role             = aws_iam_role.generate_presigned_url_lambda_role.arn
  handler          = "generate_image_to_text.lambda_handler"
  runtime          = "python3.11"
  timeout          = 30
  memory_size      = 128
  layers           = [var.layer_arn]
  filename         = data.archive_file.generate_image_to_text_zip.output_path
  source_code_hash = data.archive_file.generate_image_to_text_zip.output_base64sha256
  environment {
    variables = {
      SOURCE_BUCKET = aws_s3_bucket.file_to_be_processed.bucket,
      DEST_BUCKET= aws_s3_bucket.processed_file_bucket.bucket,
    }
  }


}
