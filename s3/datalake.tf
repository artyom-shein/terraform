provider "aws" {
  region = "us-east-1" # Choose your preferred region
  profile = "dev"
}

/* resource "aws_s3_bucket" "datalake_bucket" {
    bucket = "dev-us-east-1-datalake-test-tf" # Bucket names must be globally unique
}

resource "aws_s3_bucket_acl" "datalake_bucket_acl" {
    bucket = aws_s3_bucket.datalake_bucket.id
    acl    = "private"
}

resource "aws_s3_bucket_versioning" "datalake_bucket_versioning" {
    bucket = aws_s3_bucket.datalake_bucket.id
    versioning_configuration {
        status = "Disabled"
    }
}

resource "aws_s3_bucket_lifecycle_configuration" "datalake_bucket_lifecycle_configuration" {
    bucket = aws_s3_bucket.datalake_bucket.id
    rule {
        id = "all_objects"
        filter {}
        status = "Enabled"

        transition {
            days          = 365
            storage_class = "STANDARD_IA"
        }
    }
} */


module "s3_bucket_for_datalake" {
    source = "terraform-aws-modules/s3-bucket/aws"

    bucket = "dev-us-east-1-datalake-test-tf" 
    acl    = "private"

    #control_object_ownership = true
    #object_ownership         = "ObjectWriter"

    versioning = {
        enabled = true
    }

    lifecycle_rule = [
        {
            id      = "all_objects"
            enabled = true
            filter = {}
    
            transition = [
                {
                    days          = 365
                    storage_class = "STANDARD_IA"
                },
            ]
        },
    ]

}