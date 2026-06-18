variable "vm_name" {
  type        = string
  description = "Name of the VM"
}

variable "vm_id" {
  type        = number
  description = "Proxmox VM ID"
  default     = null
}

variable "venv_node_name" {
  type        = string
  description = "Proxmox node to provision on"

}

variable "datastore_id" {
  type        = string
  description = "Proxmox datastore for the disk"
  default     = "local-lvm"
}

variable "image_id" {
  type        = string
  description = "File ID of the bootc qcow2 image"
}

variable "vlan_id" {
  type        = number
  description = "VLAN tag for the network device"
  default     = null
}

variable "cores" {
  type    = number
  default = 2
}

variable "memory" {
  type    = number
  default = 2048
}

variable "disk_size" {
  type    = number
  default = 20
}

variable "tags" {
  type    = list(string)
  default = null
}

variable "ip_octet" {
  type        = number
  description = "Last octet of the static IP"
}

