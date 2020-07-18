provider "aws" {
    region = "eu-west-1"
}

resource "aws_s3_bucket" "imgur_image_bucket" {
    bucket = "image-up-test-docker-flask-express-db-redis-tut"

    cors_rule {
      allowed_headers = ["*"]
      allowed_methods = ["PUT", "POST"]
      allowed_origins = ["*"]
      expose_headers  = ["x-amz-server-side-encryption", "x-amz-request-id", "x-amz-id-2"]
      max_age_seconds = 3000
    }

    tags = {
        Name = "Dev Imgur Clone Bucket"
        Environment = "Dev"
    }
}

resource "aws_cognito_user_pool" "imgur_clone_pool" {
    name = "imgurclonepool"   
}

resource "aws_cognito_user_pool_client" "client" {
  name = "imgur-app-client"

  user_pool_id = "${aws_cognito_user_pool.imgur_clone_pool.id}"
}

output "UserPoolId" {
    value = "${aws_cognito_user_pool.imgur_clone_pool.id}"
}

output "UserPoolArn" {
    value = "${aws_cognito_user_pool.imgur_clone_pool.arn}"
}

output "ClientId" {
    value = "${aws_cognito_user_pool_client.client.id}"
}