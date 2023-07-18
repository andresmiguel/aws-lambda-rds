module "rds" {
  source = "./dev-rds-instance"

  db_subnet_ids      = [module.vpc.db_subnet_id_1, module.vpc.db_subnet_id_2]
  security_group_ids = [module.vpc.db_security_group_id]
  apply_immediately  = var.db_apply_immediately
}