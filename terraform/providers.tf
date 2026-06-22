terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.109.0"
    }
  }
}

provider "proxmox" {
  endpoint  = var.venv_endpoint
  api_token = var.venv_api_token
  insecure  = true
  ssh {
    agent       = true
    username    = "root"
    private_key = file("~/.ssh/id_ed25519_terraform")
  }
}
