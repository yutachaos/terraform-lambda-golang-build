variable "name" {
  type        = string
  description = "Resource name"
}

variable "asset_s3_bucket" {
  type        = string
  description = "S3 bucket for lambda upload"
}

variable "source_directory" {
  type        = string
  description = "Lambda source"
}