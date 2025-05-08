terraform {
  backend "s3" {
    bucket = "maria-iac-lab-bucket"
    key    = "root/terraform.tfstate"
    region = "ap-southeast-2"

    dynamodb_table = "maria-iac-lab-tfstate-locks"
    encrypt        = true
  }
}
