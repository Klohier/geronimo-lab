
locals {
  image_id = "local:import/bootc-fedora-44-qcow2-x86_64.qcow2"

  all_vms = merge(
    { for i, vm in module.vms : "vm-${i + 1}" => vm },
    { "caddy-01" = module.caddy },
    { "nginx-01" = module.nginx }
  )
}

module "vms" {
  source         = "./modules/vm/"
  count          = 2
  vm_name        = "vm-${count.index + 1}"
  image_id       = local.image_id
  venv_node_name = var.venv_node_name
  datastore_id   = var.datastore_id
  tags           = ["bootc"]
  ip_octet       = 60 + count.index
}

module "caddy" {
  source         = "./modules/vm/"
  vm_name        = "caddy-01"
  vm_id          = 112
  image_id       = local.image_id
  venv_node_name = var.venv_node_name
  datastore_id   = var.datastore_id
  cores          = 2
  memory         = 2048
  disk_size      = 20
  tags           = ["bootc"]
  ip_octet       = 200
}

module "nginx" {
  source         = "./modules/vm/"
  vm_name        = "nginx-01"
  vm_id          = 113
  image_id       = local.image_id
  venv_node_name = var.venv_node_name
  datastore_id   = var.datastore_id
  cores          = 2
  memory         = 2048
  disk_size      = 20
  tags           = ["bootc"]
  ip_octet       = 207
}

