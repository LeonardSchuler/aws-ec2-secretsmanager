variable "name" {
  description = "The secret name (will be suffixed)"
  type        = string
}

variable "description" {
  description = "The secret description"
  type        = string
  default     = "An example secret for demonstration purposes"
}
variable "tags" {
  description = "A map of tags to assign to resources"
  type        = map(string)
}
