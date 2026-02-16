# 1. telling terraform who to talk to

provider "aws" {
region = "ap-south-1"
}

# 2. telling to create a resource

resource "aws_s3_bucket" "my_first_bucket" { 
 bucket = "cloud-journey-vivekvardhan-2026"

 tags = {
	
	Name 		= "My First Terraform Bucket"
	Environment     = "Dev" 
}
}
