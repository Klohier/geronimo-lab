

resource "proxmox_virtual_environment_vm" "this" {
  name      = var.vm_name
  vm_id     = var.vm_id
  node_name = var.venv_node_name

  description = "Managed by Terraform"
  machine     = "q35"
  bios        = "ovmf"
  started     = true
  tags        = var.tags

  # Always set stop_on_destroy when started = true,
  # otherwise Terraform will attempt a graceful ACPI shutdown
  # that may hang if the guest agent is not installed.
  stop_on_destroy = true

  agent {
    enabled = true
  }

  cpu {
    cores = var.cores
    type  = "x86-64-v3"
  }

  memory {
    dedicated = var.memory
  }

  efi_disk {
    datastore_id = var.datastore_id
    type         = "4m"
  }

  disk {
    datastore_id = var.datastore_id
    file_id      = var.image_id
    interface    = "virtio0"
    iothread     = true
    discard      = "on"
    size         = var.disk_size
  }

  initialization {
    ip_config {
      ipv4 {
        address = "192.168.50.${var.ip_octet}/24"
        gateway = "192.168.50.1"
      }
    }
    dns {
      servers = ["192.168.50.213"]
    }
    user_account {
      username = "ansible"
      keys     = [file("~/.ssh/id_ed25519_ansible.pub")]
    }
  }
  network_device {
    bridge  = "vmbr0"
    vlan_id = var.vlan_id
  }
}

