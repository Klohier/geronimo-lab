output "vm_ipv4" {
  value = proxmox_virtual_environment_vm.this.ipv4_addresses
}

output "vm_id" {
 value = proxmox_virtual_environment_vm.this.vm_id
}
