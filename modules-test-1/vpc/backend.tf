terraform {
  backend "s3" {
    bucket         = ""
    dynamodb_table = ""
    key            = "vpc/dev/terraform.tfstate"
    region         = "us-east-1"
  }
}




# terraform {
#   backend "s3" {
#     bucket         = ""
#     dynamodb_table = ""
#     key            = ""
#     region         = ""
#   }
# }