
locals {
  image_id = "local:import/geronimo-base.qcow2"

  all_vms = merge(
    { "caddy-01" = module.caddy },
    { "nginx-01" = module.nginx },
    { "runner-01" = module.runner }
  )
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

module "runner" {
  source         = "./modules/vm/"
  vm_name        = "runner-01"
  vm_id          = 200
  image_id       = local.image_id
  venv_node_name = var.venv_node_name
  datastore_id   = var.datastore_id
  cores          = 2
  memory         = 2048
  disk_size      = 20
  tags           = ["bootc", "runner"]
  ip_octet       = 210
}

