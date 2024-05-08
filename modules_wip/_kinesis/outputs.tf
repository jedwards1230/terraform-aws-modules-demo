output "kinesis_stream_arn" {
  value = aws_kinesis_stream.example_stream.arn
}

output "firehose_stream_arn" {
  value = aws_kinesis_firehose_delivery_stream.example_firehose.arn
}
