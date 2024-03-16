variable "aws_region_main" {
  type    = string
  default = "us-east-1"
}

variable "aws_region_backup" {
  type    = string
  default = "us-east-2"
}

variable "common_tags" {
  type = map(any)
  default = {
    "id"             = "21306"
    "owner"          = "KEAK COMPANY SOFTWARE"
    "os_type"        = "RHEL8"
    "teams"          = "DEL"
    "environment"    = "dev"
    "project"        = "REVIVE"
    "managed_by"     = "Terraform"
    "cloud_provider" = "aws"
  }
}
