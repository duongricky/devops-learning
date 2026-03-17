output "s3_bucket" {
    value = {
        bucket_name = aws_s3_bucket.practice-bucket.bucket
        bucket_arn = aws_s3_bucket.practice-bucket.arn
    }
}