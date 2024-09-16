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

# Get the organization details using a data source
data "tfe_organization" "example" {
  name = var.organization_name
}

# Create the project
resource "tfe_project" "example" {
  name         = var.project_name
  organization = var.organization_name
}

# List of workspace names
variable "workspace_names" {
  type        = list(string)
  description = "The names of the workspaces to create"
  default     = ["example-workspace-01", "example-workspace-02"]
}

# Create workspaces using for_each
resource "tfe_workspace" "workspaces" {
  for_each     = toset(var.workspace_names)
  name         = each.value  # Create workspaces with the names in the list
  organization = var.organization_name
  project_id    = tfe_project.example.id # Link the workspace to the project
}
