variable "stream_name" {
  type = string
}

variable "firehose_name" {
  type = string
}

resource "aws_kinesis_stream" "example_stream" {
  name             = var.stream_name
  shard_count      = 1
  retention_period = 24
}

resource "aws_kinesis_firehose_delivery_stream" "example_firehose" {
  name        = var.firehose_name
  destination = "extended_s3"

  kinesis_source_configuration {
    kinesis_stream_arn = aws_kinesis_stream.example_stream.arn
    role_arn           = aws_iam_role.kinesis_role.arn
  }

  extended_s3_configuration {
    role_arn   = aws_iam_role.firehose_role.arn
    bucket_arn = aws_s3_bucket.example_bucket.arn
  }

  depends_on = [aws_kinesis_stream.example_stream]
}

resource "aws_s3_bucket" "example_bucket" {
  bucket = "my-firehose-bucket-${var.firehose_name}"
}

resource "aws_iam_role" "kinesis_role" {
  name = "kinesis_role_${var.stream_name}"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Principal = {
          Service = "firehose.amazonaws.com"
        }
        Effect = "Allow"
        Sid    = ""
      },
    ]
  })

}

resource "aws_iam_role" "firehose_role" {
  name = "firehose_role_${var.firehose_name}"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Principal = {
          Service = "firehose.amazonaws.com"
        }
        Effect = "Allow"
        Sid    = ""
      },
    ]
  })
}
