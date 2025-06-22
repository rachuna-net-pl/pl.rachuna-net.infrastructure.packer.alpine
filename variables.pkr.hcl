variable "keyboard_layout" {
  type        = string
  description = "Sets the keyboard layout during the setup-alpine install."
  default     = "pl"
}

variable "keyboard_variant" {
  type        = string
  description = "Sets the keyboard variant during the setup-alpine install."
  default     = "pl"
}

variable "locale" {
  type        = string
  description = "Sets the locale during the setup-alpine install."
  default     = "pl_PL.UTF-8"
}

variable "timezone" {
  type        = string
  description = "Sets the timezone during the setup-alpine install."
  default     = "EUROPE/WARSAW"
}

variable "dns_servers" {
  type        = list(string)
  description = "Sets the DNS servers during the setup-alpine install."
  default     = []

  validation {
    condition     = var.dns_servers != null
    error_message = "The DNS server list must not be null. An empty list is allowed."
  }
}