module "saver-bot" {
  source = "./saver-bot"

  rds_instance_arn        = module.rds.db_instance_arn
  rds_instance_identifier = module.rds.db_instance_identifier
  ec2_instance_arn        = module.bastion-host.instance_arn
  ec2_instance_id         = module.bastion-host.instance_id
}