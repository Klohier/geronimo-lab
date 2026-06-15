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

}
