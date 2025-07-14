module "network" {
  source = "./resources/network"
}

module "vm" {
  source         = "./resources/vm"
  ssh_public_key = var.ssh_public_key
}

module "keyvault" {
  source       = "./resources/keyvault"
  tenant_id    = var.tenant_id
  vm_object_id = module.vm.vm_object_id
}
