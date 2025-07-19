 module "network" {
   source = "./modules/network"
 }

 module "vm" {
   source         = "./modules/vm"
   ssh_public_key = var.ssh_public_key

   rg_name        = module.network.rg_name
   location       = module.network.location
   subnet_id      = module.network.subnet_id
   key_vault_name = module.keyvault.key_vault_name

 }

 module "keyvault" {
   source       = "./modules/keyvault"
   tenant_id    = var.tenant_id
   vm_object_id = module.vm.vm_object_id

   rg_name      = module.network.rg_name
   location     = module.network.location
 }



