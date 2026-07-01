
locals {
  image_id         = "local:import/geronimo-base2.qcow2"
  image_k3s_server = "local:import/geronimo-k3s-server.qcow2"
  image_k3s_agent  = "local:import/geronimo-k3s-agent.qcow2"

  k3s_agents = {
    "01" = { vm_id = 301, ip_octet = 221 }
    "02" = { vm_id = 302, ip_octet = 222 }
    "03" = { vm_id = 303, ip_octet = 223 }
  }

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


module "k3s-server" {
  source         = "./modules/vm/"
  vm_name        = "k3s-server"
  vm_id          = 300
  image_id       = local.image_k3s_server
  venv_node_name = var.venv_node_name
  datastore_id   = var.datastore_id
  cores          = 2
  memory         = 8192
  disk_size      = 20
  tags           = ["bootc", "k3s-server"]
  ip_octet       = 220

}
module "k3s-agent" {
  for_each = local.k3s_agents

  source         = "./modules/vm/"
  vm_name        = "k3s-agent-${each.key}"
  vm_id          = each.value.vm_id
  image_id       = local.image_k3s_agent
  venv_node_name = var.venv_node_name
  datastore_id   = var.datastore_id
  cores          = 2
  memory         = 2048
  disk_size      = 20
  tags           = ["bootc", "k3s-agent"]
  ip_octet       = each.value.ip_octet
}
