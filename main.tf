

resource "proxmox_virtual_environment_vm" "example" {
  name      = "example-vm"
  node_name = var.venv_node_name

  description = "Managed by Terraform"
  machine     = "q35"
  bios        = "ovmf"
  started     = true

  # Always set stop_on_destroy when started = true,
  # otherwise Terraform will attempt a graceful ACPI shutdown
  # that may hang if the guest agent is not installed.
  stop_on_destroy = true

  agent {
    enabled = true
  }

  cpu {
    cores = 2
    type  = "x86-64-v3"
  }

  memory {
    dedicated = 2048
  }

  efi_disk {
    datastore_id = var.datastore_id
    type         = "4m"
  }

  disk {
    datastore_id = var.datastore_id
    file_id      = "local:import/rhel.qcow2"
    interface    = "virtio0"
    iothread     = true
    discard      = "on"
    size         = 20
  }

  initialization {
    ip_config {
      ipv4 {
        address = "dhcp"
      }
    }
  }

  network_device {
    bridge = "vmbr0"
  }
}

output "vm_ipv4" {
  value = proxmox_virtual_environment_vm.example.ipv4_addresses
}
