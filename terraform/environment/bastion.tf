module "bastion-host" {
  source = "./bastion-host"

  subnet_id          = module.vpc.bastion_host_subnet_id
  security_group_ids = [module.vpc.bastion_host_security_group_id]
  key_name           = var.bastion_host_key_name
}