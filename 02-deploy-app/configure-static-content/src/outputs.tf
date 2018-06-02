output "site_bucket" {
  value = "${module.static_site.site_bucket}"
}

output "logs_bucket" {
  value = "${module.static_site.logs_bucket}"
}

output "website_cdn_hostname" {
  value = "${aws_cloudfront_distribution.site.domain_name}"
}