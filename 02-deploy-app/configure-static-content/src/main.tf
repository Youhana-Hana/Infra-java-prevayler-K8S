provider "aws" {
  region     = "${var.region}"
}

module "static_site" {
  source                      = "github.com/azavea/terraform-aws-s3-origin?ref=0.1.0"
  bucket_name                 = "${var.bucket_name}"
  logs_bucket_name            = "logs.${var.bucket_name}"
  project                     = "${var.project}"
  environment                 = "${var.environment}"
  region                      = "${var.region}"
}


#
# Cloudfront Distribution
#
resource "aws_cloudfront_distribution" "site" {
  origin {
    domain_name = "${module.static_site.site_bucket}.s3.amazonaws.com"
    origin_id   = "origin-bucket-${module.static_site.site_bucket}"
  }

  enabled             = true
  
  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "origin-bucket-${module.static_site.site_bucket}"

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
        }
      }

    viewer_protocol_policy = "allow-all"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
    compress               = true
    }

 restrictions {
    geo_restriction {
      restriction_type = "none"
      }
    }
  viewer_certificate {
    cloudfront_default_certificate = true
  }

tags = "${merge("${var.tags}",map("Name", "${var.project}-${var.environment}", "Environment", "${var.environment}", "Project", "${var.project}"))}"

}