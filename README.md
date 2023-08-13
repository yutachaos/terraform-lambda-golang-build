# Lambda Golang Build and S3 Deploy Terraform Module

This Terraform module automates the process of building a Golang binary for an AWS Lambda function and deploying the binary to an Amazon S3 bucket. It simplifies the deployment of your Lambda function by handling the compilation of Golang code and managing the binary's distribution.

## Prerequisites

- An AWS account configured with appropriate IAM permissions.
- Terraform installed on your local machine.

## Usage

```hcl
module "lambda_golang_build" {
  source = "github.com/yutachaos/terraform-lambda-golang-build"
  
  name = "my-binary-name"
  golang_code_path    = "./lambda_source"
  s3_bucket_name      = "my-s3-bucket"
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |
| <a name="provider_null"></a> [null](#provider\_null) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [null_resource.lambda_build](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [aws_s3_object.golang_zip](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/s3_object) | data source |
| [aws_s3_object.golang_zip_hash](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/s3_object) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_asset_s3_bucket"></a> [asset\_s3\_bucket](#input\_asset\_s3\_bucket) | S3 bucket for lambda upload | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Resource name | `string` | n/a | yes |
| <a name="input_source_directory"></a> [source\_directory](#input\_source\_directory) | Lambda source | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_golang_zip_hash"></a> [golang\_zip\_hash](#output\_golang\_zip\_hash) | n/a |
| <a name="output_s3_zip_key"></a> [s3\_zip\_key](#output\_s3\_zip\_key) | n/a |
<!-- END_TF_DOCS -->