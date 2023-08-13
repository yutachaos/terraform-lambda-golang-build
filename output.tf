output "s3_zip_key" {
  value = data.aws_s3_object.golang_zip.key
}

output "golang_zip_hash" {
  value = data.aws_s3_object.golang_zip_hash.body
}