variable region {
  default = "us-east-1"
}

variable project {
  default = "company news"
}

variable environment {
  default = "development"
}

variable bucket_name {
  description = "The name of the S3 bucket to create."
}

variable "tags" {
  type        = "map"
  description = "Optional Tags"
  default     = {}
}

variable "forward-query-string" {
  description = "Forward the query string to the origin"
  default     = false
}
