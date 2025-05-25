resource "aws_kinesis_stream" "stream" {
  name = "datacenter-stream"
  shard_count = 1
  stream_mode_details {
    stream_mode = "PROVISIONED"
  }

}