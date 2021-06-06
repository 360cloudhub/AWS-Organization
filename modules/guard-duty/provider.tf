provider "aws" {
  region = var.region
}

provider "aws" {
  alias = "admin"
  region = var.region
  profile = var.guardduty_admin_aws_profile_name
}

provider "aws" {
  alias = "member"
  region = var.region
  profile = var.guardduty_member_aws_profile_name
}