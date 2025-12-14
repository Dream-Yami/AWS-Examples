resource "aws_s3_bucket" "terraform-s3-bucket-seanbelon" {
  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

# To build is Terraform plan, then terraform apply
# To tear is Terraform 