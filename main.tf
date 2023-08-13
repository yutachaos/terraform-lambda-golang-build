resource "null_resource" "lambda_build" {

  triggers = {
    code_diff = join("", concat(
      [
        for file in fileset(var.source_directory, "**.go")
        : filebase64("${var.source_directory}/${file}")
      ],
      [filebase64("${var.source_directory}/go.mod")],
      [filebase64("${var.source_directory}/go.sum")]
    ))
    name = var.name
  }

  provisioner "local-exec" {
    command = "cd ${var.source_directory} && GOARCH=amd64 GOOS=linux go build -o main *.go"
  }

  provisioner "local-exec" {
    command = "zip -j ${var.source_directory}/source.zip ${var.source_directory}/main"
  }
  provisioner "local-exec" {
    command = "aws s3 cp ${var.source_directory}/source.zip s3://${var.asset_s3_bucket}/${var.name}/source.zip"
  }
  provisioner "local-exec" {
    command = "openssl dgst -sha256 -binary ${var.source_directory}/source.zip | openssl enc -base64 | tr -d \"\n\" > ${var.source_directory}/source.zip.base64sha256.txt"
  }
  provisioner "local-exec" {
    command = "aws s3 cp ${var.source_directory}/source.zip.base64sha256.txt s3://${var.asset_s3_bucket}/${var.name}/source.zip.base64sha256.txt --content-type \"text/plain\""
  }
}


data "aws_s3_object" "golang_zip" {
  depends_on = [null_resource.lambda_build]

  bucket = var.asset_s3_bucket
  key    = "${var.name}/source.zip"
}

data "aws_s3_object" "golang_zip_hash" {
  depends_on = [null_resource.lambda_build]

  bucket = var.asset_s3_bucket
  key    = "${var.name}/source.zip.base64sha256.txt"
}