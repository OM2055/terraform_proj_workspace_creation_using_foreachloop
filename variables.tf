# Input variables for organization name and token
variable "organization_name" {
  type        = string
  description = "The name of the organization in Terraform Cloud"
}

variable "tfe_token" {
  type        = string
  description = "The API token for Terraform Cloud"
  sensitive   = true
}

variable "project_name" {
  type        = string
  description = "The name of the project to create"
  default     = "TCS_Test"  # Set the default project name
}

