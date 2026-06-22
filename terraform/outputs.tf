output "vms" {
  description = "Map of VM names to IDs and IPs"
  value = {
    for name, vm in local.all_vms : name => {
      id = vm.vm_id
      ip = length(vm.vm_ipv4) > 0 && length(vm.vm_ipv4[0]) > 0 ? vm.vm_ipv4[1][0] : "pending"
    }
  }
}
