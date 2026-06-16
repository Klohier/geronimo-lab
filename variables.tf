variable "venv_node_name" {
  type        = string
  description = "Proxmox node name"
}

variable "datastore_id" {
  type        = string
  description = "Proxmox datastore for VM disks"
}

variable "venv_endpoint" {
  type        = string
  description = "Proxmox API endpoint URL"
}

variable "venv_api_token" {
  type        = string
  description = "Proxmox API token"
  sensitive   = true
}
