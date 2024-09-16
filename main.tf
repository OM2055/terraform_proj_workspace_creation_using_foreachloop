terraform {
  cloud {
    organization = "TCS_BG"  # Replace with your organization
    workspaces {
      name = "terraform_cloud_workspace_sentinel"
    }
  }
}

provider "tfe" {
  hostname = "app.terraform.io"
  token    = var.tfe_token  # Replace with your Terraform Cloud token
}

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
  default     = "TCS_Test01"  # Set the default project name
}

# List of workspace names
variable "workspace_names" {
  type        = list(string)
  description = "The names of the workspaces to create"
  default     = ["example-workspace-01", "example-workspace-02"]
}

# Get the organization details using a data source
data "tfe_organization" "example" {
  name = var.organization_name
}

# Create the project
resource "tfe_project" "example" {
  name         = var.project_name
  organization = var.organization_name
}

# Create workspaces using for_each
resource "tfe_workspace" "workspaces" {
  for_each     = toset(var.workspace_names)
  name         = each.value  # Create workspaces with the names in the list
  organization = var.organization_name
}
