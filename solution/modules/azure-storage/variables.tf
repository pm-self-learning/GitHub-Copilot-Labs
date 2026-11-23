variable "name" {
  description = "Globally unique Storage Account name: 3-24 lowercase letters and digits."
  type        = string
  nullable    = false

  validation {
    condition     = can(regex("^[a-z0-9]{3,24}$", var.name))
    error_message = "Use 3-24 lowercase letters or digits for the Storage Account name."
  }
}

variable "resource_group_name" {
  description = "Name of an existing Resource Group; this module does not create one."
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.resource_group_name)) > 0
    error_message = "Provide a non-empty existing Resource Group name."
  }
}

variable "location" {
  description = "Azure region for the Storage Account, such as eastus."
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.location)) > 0
    error_message = "Provide a non-empty Azure region."
  }
}

variable "container_name" {
  description = "Blob container name: 3-63 lowercase letters, digits, or single hyphens, with alphanumeric ends."
  type        = string
  nullable    = false

  validation {
    condition = (
      can(regex("^[a-z0-9][a-z0-9-]{1,61}[a-z0-9]$", var.container_name)) &&
      !strcontains(var.container_name, "--")
    )
    error_message = "Use 3-63 lowercase letters, digits, or hyphens, with alphanumeric ends and no consecutive hyphens."
  }
}

variable "tags" {
  description = "Storage Account tags, including non-empty Environment, Owner, and Project values."
  type        = map(string)
  nullable    = false

  validation {
    condition = alltrue([
      for key in ["Environment", "Owner", "Project"] :
      try(length(trimspace(var.tags[key])) > 0, false)
    ])
    error_message = "Tags must include non-empty, case-sensitive Environment, Owner, and Project values."
  }
}
