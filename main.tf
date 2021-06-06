module "qa_ou" {
  source = "./modules/aws-organization"

  ou_name = "qa"
}

module "qa_child" {
  source = "./modules/aws-organization"

  ou_name = "qa_child"
  ou_parent_id = module.qa_ou.ou_id
}


module "gd_admin" {
  source = "./modules/guard-duty"

  admin_account_id = ""
  guardduty_admin_aws_profile_name = ""
  guardduty_member_aws_profile_name = ""
  region = "us-east-1"
}

module "gd_member" {
  source = "./modules/guard-duty"

  member_account_id = ""
  admin_detector_id = module.gd_admin.admin_detector_id
  guardduty_admin_aws_profile_name = "cloudmarathadev"
  guardduty_member_aws_profile_name = ""
  email_id = ""
  region = "us-east-1"
}

module "gd_member1" {
  source = "./modules/guard-duty"

  member_account_id = ""
  admin_detector_id = module.gd_admin.admin_detector_id
  guardduty_admin_aws_profile_name = ""
  guardduty_member_aws_profile_name = ""
  email_id = ""
  region = "us-east-1"
}